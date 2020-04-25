//
//  NewsFilterViewModel.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/8/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import UIKit

protocol NewsFilterViewModelDelegate: class {
  func refreshForm()
  func filterSaved()
  func onSavingFailed(with reason: NetworkError)
}

final class NewsFilterViewModel {
  weak var delegate: NewsFilterViewModelDelegate?

  private var title: String = ""
  private var content: String = ""
  private var sources: [String] = []
  private var firstDate: Date?
  private var secondDate: Date?

  var selectedTitle: String {
    return title
  }

  var selectedContent: String {
    return content
  }

  var selectedSources: [String] {
    return sources
  }

  var first: Date? {
    return firstDate
  }

  var second: Date? {
    return secondDate
  }

  func getSavedFilter() {
    let savedFilter = DataManager.shared.filter
    self.title = savedFilter.title ?? ""
    self.content = savedFilter.content ?? ""
    self.sources = []
    for source in savedFilter.sources {
      self.sources.append(source)
    }
    self.firstDate = savedFilter.firstDate
    self.secondDate = savedFilter.secondDate
    self.delegate?.refreshForm()
  }

  func updateFilter(title: String?, content: String?, sources: [String], startDate: Date?, endDate: Date?) {
    var sourcesInt: [Int] = []
    let group = DispatchGroup()

    for source in sources {
      group.enter()
      NetworkingManager.news.getSources() { (answer) in
        group.leave()
        switch answer {
        case .success(let sources):
          var newSources: [Int] = []
          for source in sources {
            newSources.append(source.id)
          }
          sourcesInt.append(contentsOf: newSources)

        case .failure(let error):
          self.delegate?.onSavingFailed(with: error)
        }
      }
    }

    group.notify(queue: .main) {
      self.saveFilter(title: title, content: content, sources: sources, sourcesInt: sourcesInt, startDate: startDate, endDate: endDate)
    }
  }

  private func saveFilter(title: String?, content: String?, sources: [String], sourcesInt: [Int], startDate: Date?, endDate: Date?) {
    let newFilter = FilterCache(title: title, content: content, sources: sources, sourcesInt: sourcesInt, firstDate: startDate, secondDate: endDate)
    DataManager.shared.filter = newFilter
    self.delegate?.filterSaved()
  }
}
