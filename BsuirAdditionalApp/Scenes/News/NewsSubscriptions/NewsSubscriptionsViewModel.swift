//
//  NewsSubscriptionsViewModel.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 4/26/20.
//  Copyright © 2020 Kiryl Holubeu. All rights reserved.
//

import UIKit

protocol NewsSubscriptionsViewModelDelegate: class {
  func onFetchCompleted()
  func onFetchFailed(with reason: NetworkError)
}

final class NewsSubscriptionsViewModel {
  weak var delegate: NewsSubscriptionsViewModelDelegate?
  
  private var subscriptions: SubscriptionsCache!
  private var subscriptionsStrings: [String] = []
  private var categories: [String] = []
  private var categorizedSources: [String: [SourceCache]] = [:]
  
  private var isFetchInProgress = false
  
  var fetching: Bool {
    return isFetchInProgress
  }
  
  var categoriesCount: Int {
    return categories.count
  }
  
  func name(of category: Int) -> String {
    return categories[category]
  }
  
  func sourcesCount(in category: Int) -> Int {
    return categorizedSources[categories[category]]!.count
  }
  
  func source(at indexPath: IndexPath) -> SourceCache? {
    return categorizedSources[categories[indexPath.section]]?[indexPath.row]
  }

  func refresh(refresher: Bool) {
    guard !isFetchInProgress else {
      return
    }

    fetchSources()
  }
  
  func getSavedSubscription() {
    subscriptions = DataManager.shared.subscriptions
    self.delegate?.onFetchCompleted()
  }
  
  func updateSubcription(indexPath: IndexPath, subscribe: Bool) {
    categorizedSources[categories[indexPath.section]]?[indexPath.row].subscribed = subscribe
    guard let alias = categorizedSources[categories[indexPath.section]]?[indexPath.row].alias else {
      return
    }
    if subscribe {
      subscriptionsStrings.append(alias)
    } else {
      subscriptionsStrings.removeAll { (subscribed) -> Bool in
        return subscribed == alias
      }
    }
    updateSubscriptions(with: subscriptionsStrings)
  }
  
  private func fetchSources(completion: (() -> Void)? = nil) {
    guard !isFetchInProgress else {
      return
    }

    isFetchInProgress = true

    NetworkingManager.news.getSources { (answer) in
      switch answer {
      case .success(let sources):
        completion?()
        self.isFetchInProgress = false
        self.subscriptions = SubscriptionsCache(sources: sources)
        self.delegate?.onFetchCompleted()
        DataManager.shared.subscriptions = self.subscriptions
        self.fetchSourcesStatus()
      case .failure(let error):
        completion?()
        self.isFetchInProgress = false
        self.delegate?.onFetchFailed(with: error)
      }
    }
  }
  
  private func fetchSourcesStatus(completion: (() -> Void)? = nil) {
    guard !isFetchInProgress else {
      return
    }

    isFetchInProgress = true
    
    NetworkingManager.news.getSubscriptions { (answer) in
      switch answer {
      case .success(let subs):
        completion?()
        self.isFetchInProgress = false
        self.sortSources(with: subs)
        self.delegate?.onFetchCompleted()
        DataManager.shared.subscriptions = self.subscriptions
      case .failure(let error):
        completion?()
        self.isFetchInProgress = false
        self.delegate?.onFetchFailed(with: error)
      }
    }
  }
  
  private func updateSubscriptions(with subs: [String]) {
    NetworkingManager.news.subscribe(to: subs) { (answer) in
      switch answer {
      case .success(let subs):
        self.isFetchInProgress = false
        self.sortSources(with: subs)
        self.delegate?.onFetchCompleted()
        DataManager.shared.subscriptions = self.subscriptions
      case .failure(let error):
        print(error)
      }
    }
  }
  
  private func sortSources(with subs: [String]) {
    subscriptionsStrings = subs
    categories = []
    categorizedSources = [:]
    for source in self.subscriptions.sources {
      if subs.contains(source.alias)  {
        source.subscribed = true
      } else {
        source.subscribed = false
      }
      
      if !categories.contains(source.type) {
        categories.append(source.type)
      }
      
      if categorizedSources[source.type] == nil {
        categorizedSources[source.type] = []
      }
      categorizedSources[source.type]?.append(source)
    }
    
    categories.sort()
  }
}

