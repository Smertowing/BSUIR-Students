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
  
  private var sources: [Source] = []
  private var categories: [String] = []
  private var categorizedSources: [String: [Source]] = [:]
  
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
  
  func source(at indexPath: IndexPath) -> Source? {
    return categorizedSources[categories[indexPath.section]]?[indexPath.row]
  }

  func refresh(refresher: Bool) {
    guard !isFetchInProgress else {
      return
    }

    fetchSources()
  }
  
  private func fetchSources(completion: (() -> Void)? = nil) {
    guard !isFetchInProgress else {
      return
    }

    isFetchInProgress = true

    NetworkingManager.news.getSources { (answer) in
      switch answer {
      case .success(let sources):
        DispatchQueue.main.async {
          completion?()
          self.isFetchInProgress = false
          self.sources = sources
          self.fetchSourcesStatus()
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
  
  private func fetchSourcesStatus(completion: (() -> Void)? = nil) {
    guard !isFetchInProgress else {
      return
    }

    isFetchInProgress = true
    
    NetworkingManager.news.getSubscriptions { (answer) in
      switch answer {
      case .success(let subs):
        DispatchQueue.main.async {
          completion?()
          self.isFetchInProgress = false
          self.sortSources(with: subs)
          self.delegate?.onFetchCompleted()
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
  
  private func sortSources(with subs: [String]) {
    categories = []
    categorizedSources = [:]
    for var source in sources {
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

