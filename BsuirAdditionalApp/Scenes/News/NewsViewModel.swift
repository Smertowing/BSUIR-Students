//
//  NewsViewModel.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/1/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import UIKit

protocol NewsViewModelDelegate: class {
  func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?)
  func onFetchFailed(with reason: NetworkError)
  func reloadTabs()
}

final class NewsViewModel {
  weak var delegate: NewsViewModelDelegate?

  private var newsList: NewsList? {
    willSet {
      guard let value = newValue else {
        return
      }
      total = value.totalElements
      news.append(contentsOf: value.content)

      if value.page > 1 {
        let indexPathsToReload = self.calculateIndexPathsToReload(from: value.content)
        self.delegate?.onFetchCompleted(with: indexPathsToReload)
      } else {
        self.delegate?.onFetchCompleted(with: .none)
      }
    }
  }

  private var news: [News] = []
  private var currentPage = 1
  private var perPage = 10
  private var total = 0
  private var isFetchInProgress = false

  private var title: String?
  private var content: String?
  private var sources: [Int] = []
  private var firstDate: Date?
  private var secondDate: Date?

  var totalCount: Int {
    return total
  }

  var currentCount: Int {
    return news.count
  }

  func news(at index: Int) -> News {
    return news[index]
  }
  
  private var subscriptions: SubscriptionsCache!
  private var tabs: [SourceCache] = []
  private var currentTabNumber = 0

  var numberOfTabs: Int {
    return tabs.count
  }
  
  var currentTab: Int {
    return currentTabNumber
  }
  
  func tab(at index: Int) -> SourceCache {
    return tabs[index]
  }
  
  func updateTab(to index: Int) {
    currentTabNumber = index
    refresh(refresher: false)
  }
  
  func getSavedSubscriptions() {
    subscriptions = DataManager.shared.subscriptions
    for source in subscriptions.sources {
      if source.subscribed  {
        tabs.append(source)
      }
    }
    delegate?.reloadTabs()
    fetchSources()
  }
  
  var fetching: Bool {
    return isFetchInProgress
  }

  func refresh(refresher: Bool) {
    guard !isFetchInProgress else {
      return
    }

    getSavedFilter()

    currentPage = 1
    total = 0

    fetchNews(page: 1, perPage: perPage) {
      self.news = []
    }
  }

  func fetch() {
    fetchNews(page: currentPage, perPage: perPage)
  }

  private func fetchNews(page: Int, perPage: Int, completion: (() -> Void)? = nil) {
    guard !isFetchInProgress else {
      return
    }

    isFetchInProgress = true
    
    var filters: [Filter] = []
    if currentTab == 1 {
      filters.append(Filter(type: .string,
                            comparison: .includes,
                            value: tabs.map({ (tab) -> String in
                              return tab.alias
                            }),
                            field: "source.alias"))
    } else if currentTab > 1 {
      filters.append(Filter(type: .string,
                            comparison: .equels,
                            value: [tabs[currentTab-2].alias],
                            field: "source.alias"))
    }
    
    NetworkingManager.news.getNewsList(page: page, newsAtPage: perPage, sort: nil, filters: filters) { (answer) in
      switch answer {
      case .success(let newsList):
        DispatchQueue.main.async {
          completion?()
          self.currentPage += 1
          self.isFetchInProgress = false
          self.newsList = newsList
        }
      case .failure(let error):
        DispatchQueue.main.async {
          completion?()
          self.isFetchInProgress = false
          self.delegate?.onFetchFailed(with: error)
        }
      }
    }
  }
  
  private func fetchSources(completion: (() -> Void)? = nil) {
    NetworkingManager.news.getSources { (answer) in
      switch answer {
      case .success(let sources):
        DispatchQueue.main.async {
          completion?()
          self.subscriptions = SubscriptionsCache(sources: sources)
          DataManager.shared.subscriptions = self.subscriptions
          self.fetchSourcesStatus()
        }
      case .failure(let error):
        completion?()
        print(error)
      }
    }
  }
  
  private func fetchSourcesStatus(completion: (() -> Void)? = nil) {
    NetworkingManager.news.getSubscriptions { (answer) in
      switch answer {
      case .success(let subs):
        DispatchQueue.main.async {
          completion?()
          self.sortSources(with: subs)
          DataManager.shared.subscriptions = self.subscriptions
          self.delegate?.reloadTabs()
        }
      case .failure(let error):
        completion?()
        print(error)
      }
    }
  }
  
  private func sortSources(with subs: [String]) {
    tabs = []
    for source in self.subscriptions.sources {
      if subs.contains(source.alias)  {
        source.subscribed = true
        tabs.append(source)
      } else {
        source.subscribed = false
      }
    }
  }

  private func calculateIndexPathsToReload(from newNews: [News]) -> [IndexPath] {
    let startIndex = news.count - newNews.count
    let endIndex = startIndex + newNews.count
    return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
  }

  func getSavedFilter() {
    let savedFilter = DataManager.shared.filter
    self.title = savedFilter.title
    self.content = savedFilter.content
    self.sources = savedFilter.sourcesInt
    self.firstDate = savedFilter.firstDate
    self.secondDate = savedFilter.secondDate
  }
}
