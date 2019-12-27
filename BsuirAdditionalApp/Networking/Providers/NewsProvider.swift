//
//  NewsProvider.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/1/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import Moya

enum NewsProvider {
  case getNews(id: Int)
  case getNewsList(page: Int?, newsAtPage: Int?, title: String?, q: String?, url: String?, source: Int?,
    sources: [Int]?, loadedAfter: TimeInterval?, loadedBefore: TimeInterval?, publishedAfter: TimeInterval?, publishedBefore: TimeInterval?)
  case getSources(type: NewsSourceType)
}

extension NewsProvider: TargetType {
  var baseURL: URL {
    return URL(string: Config.apiUrl)!
  }

  var path: String {
    switch self {
    case .getNews:
      return "/news"
    case .getNewsList:
      return "/newsList"
    case .getSources:
      return "/sources"
    }
  }

  var method: Method {
    switch self {
    case .getNews:
      return .get
    case .getNewsList:
      return .get
    case .getSources:
      return .get
    }
  }

  var sampleData: Data {
    return Data()
  }

  var task: Task {
    switch self {
    case .getNews(let id):
      return .requestParameters(
        parameters: ["id": id],
        encoding: URLEncoding.default
      )
    case .getNewsList(let page, let newsAtPage, let title, let q, let url, let source, let sources, let loadedAfter,
                      let loadedBefore, let publishedAfter, let publishedBefore):
      var params: [String: Any] = [:]
      if let page = page {
        params["page"] = page
      }
      if let newsAtPage = newsAtPage {
        params["newsAtPage"] = newsAtPage
      }
      if let title = title {
        params["title"] = title
      }
      if let q = q {
        params["q"] = q
      }
      if let url = url {
        params["url"] = url
      }
      if let source = source {
        params["source"] = source
      }
      if let sources = sources {
        params["sources"] = sources
      }
      if let loadedAfter = loadedAfter {
        params["loadedAfter"] = loadedAfter
      }
      if let loadedBefore = loadedBefore {
        params["loadedBefore"] = loadedBefore
      }
      if let publishedAfter = publishedAfter {
        params["publishedAfter"] = publishedAfter
      }
      if let publishedBefore = publishedBefore {
        params["publishedBefore"] = publishedBefore
      }
      return .requestParameters(
        parameters: params,
        encoding: URLEncoding.default
      )
    case .getSources(let type):
      return .requestParameters(
        parameters: ["type": type.rawValue],
        encoding: URLEncoding.default
      )
    }
  }

  var headers: [String: String]? {
    switch self {
    case .getNews:
      return ["Content-Type": "application/json"]
    case .getNewsList:
      return ["Content-Type": "application/json"]
    case .getSources:
      return ["Content-Type": "application/json"]
    }
  }

  var validationType: ValidationType {
    return .successCodes
  }
}
