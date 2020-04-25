//
//  NewsDetailsViewModel.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 4/25/20.
//  Copyright © 2020 Kiryl Holubeu. All rights reserved.
//

import UIKit

protocol NewsDetailsViewModelDelegate: class {
  func reloadContent()
}

final class NewsDetailsViewModel {
  weak var delegate: NewsDetailsViewModelDelegate?

  private var currentNews: News!

  func setCurrentNews(with news: News) {
    currentNews = news
  }
  
  var id: Int {
    return currentNews.id
  }
  
  var title: String {
    return currentNews.title
  }
  
  var source: Source {
    return currentNews.source
  }
  
  var date: String {
    return currentNews.publishedAt
  }
  
  var content: String? {
    return currentNews.content
  }
  
  var url: URL? {
    return URL(string: currentNews.url)
  }
  
  func loadContent() {
    NetworkingManager.news.getNews(by: currentNews.id) { (answer) in
      switch answer {
      case .success(let news):
        self.currentNews = news
        self.delegate?.reloadContent()
      case .failure(let error):
        print(error)
      }
    }
  }
}

