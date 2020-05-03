//
//  NotificationsProvider.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 5/3/20.
//  Copyright © 2020 Kiryl Holubeu. All rights reserved.
//

import Moya

enum NotificationsProvider {
  case subscribe(token: String)
  case unsubscribe(token: String)
  case test
}

extension NotificationsProvider: TargetType {
  
  var baseURL: URL {
    return URL(string: Config.apiUrl)!
  }
  
  var path: String {
    switch self {
    case .subscribe:
      return "/push-notifications"
    case .unsubscribe(let token):
      return "/push-notifications/\(token)"
    case .test:
      return "/push-notifications/test"
    }
  }
  
  var method: Method {
    switch self {
    case .subscribe:
      return .post
    case .unsubscribe:
      return .delete
    case .test:
      return .post
    }
  }
  
  var sampleData: Data {
    return Data()
  }
  
  var task: Task {
    switch self {
    case .subscribe(let token):
      return .requestParameters(
        parameters: [
          "token": token,
          "tokenType": "APPLE_TOKEN"
        ],
        encoding: JSONEncoding.default
      )
    case .unsubscribe:
      return .requestPlain
    case .test:
      return .requestPlain
    }
  }
  
  var headers: [String : String]? {
    switch self {
    case .subscribe:
      return ["Content-Type": "application/json",
      "Authorization": "Bearer " + ProfileManager.shared.token]
    case .unsubscribe:
      return ["Content-Type": "application/json",
      "Authorization": "Bearer " + ProfileManager.shared.token]
    case .test:
      return ["Content-Type": "application/json",
      "Authorization": "Bearer " + ProfileManager.shared.token]
    }
  }
  
  var validationType: ValidationType {
    return .successCodes
  }
  
}

