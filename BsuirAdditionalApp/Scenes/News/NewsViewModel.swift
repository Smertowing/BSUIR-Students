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
  
  private var tabs: [Source] = []
  private var currentTabNumber = 0

  var numberOfTabs: Int {
    return tabs.count
  }
  
  var currentTab: Int {
    return currentTabNumber
  }
  
  func tab(at index: Int) -> Source {
    return tabs[index]
  }
  
  func updateTab(to index: Int) {
    currentTabNumber = index
    delegate?.reloadTabs()
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

    NetworkingManager.news.getNewsList(page: page, newsAtPage: perPage, sort: nil, filters: []) { (answer) in
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
