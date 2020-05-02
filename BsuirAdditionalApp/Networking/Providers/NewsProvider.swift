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
  case searchNews(page: Int?, newsAtPage: Int?, sort: Sort?, filters: [Filter]?)
  case getSources
  case getSubscriptions
  case subscribe(to: [String])
}

extension NewsProvider: TargetType {
  var baseURL: URL {
    return URL(string: Config.apiUrl)!
  }

  var path: String {
    switch self {
    case .getNews(let id):
      return "/news/\(id)"
    case .searchNews:
      return "/news/search"
    case .getSources:
      return "/news/sources"
    case .getSubscriptions:
      return "/news/sources/subscriptions"
    case .subscribe:
      return "/news/sources/subscriptions"
    }
  }

  var method: Method {
    switch self {
    case .getNews:
      return .get
    case .searchNews:
      return .post
    case .getSources:
      return .get
    case .getSubscriptions:
      return .get
    case .subscribe:
      return .put
    }
  }

  var sampleData: Data {
    return Data()
  }

  var task: Task {
    switch self {
    case .getNews:
      return .requestPlain
    case .searchNews(let page, let newsAtPage, let sort, let filters):
      var params: [String: Any] = [:]
      if let page = page {
        params["page"] = page
      }
      if let newsAtPage = newsAtPage {
        params["pageSize"] = newsAtPage
      }
      if let sort = sort {
        var sorting: [String: Any] = [:]
        sorting["field"] = sort.field
        sorting["type"] = sort.type.rawValue
        params["sort"] = sorting
      }
      if let filters = filters {
        var filtersArray: [[String: Any]] = []
        for filter in filters {
          var filterDict: [String: Any] = [:]
          filterDict["type"] = filter.type.rawValue
          filterDict["comparison"] = filter.comparison.rawValue
          filterDict["value"] = filter.value
          filterDict["field"] = filter.field
          filtersArray.append(filterDict)
        }
        params["filters"] = filtersArray
      }
      return .requestParameters(
        parameters: params,
        encoding: JSONEncoding.default
      )
    case .getSources:
      return .requestPlain
    case .getSubscriptions:
      return .requestPlain
    case .subscribe(let to):
      return .requestParameters(
        parameters: ["newsSourcesAliases": to],
        encoding: JSONEncoding.default
      )
    }
  }

  var headers: [String: String]? {
    switch self {
    case .getNews:
      return ["Content-Type": "application/json"]
    case .searchNews:
      return ["Content-Type": "application/json"]
    case .getSources:
      return ["Content-Type": "application/json",
              "Authorization": "Bearer " + ProfileManager.shared.token]
    case .getSubscriptions:
      return ["Content-Type": "application/json",
              "Authorization": "Bearer " + ProfileManager.shared.token]
    case .subscribe:
      return ["Content-Type": "application/json",
              "Authorization": "Bearer " + ProfileManager.shared.token]
    }
  }

  var validationType: ValidationType {
    return .successCodes
  }
}
