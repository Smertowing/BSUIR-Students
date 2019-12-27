//
//  IISProvider.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/1/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import Moya

enum IISProvider {
  case auth(login: String, password: String)
  case getUser(id: Int)
  case getProfile
  case getRecordBook
  case getDiploma
  case getGroup
  case getSettings
  case updateSettings(settings: UserSettings)
}

extension IISProvider: TargetType {
  var baseURL: URL {
    return URL(string: Config.apiUrl)!
  }

  var path: String {
    switch self {
    case .auth:
      return "/auth"
    case .getUser(let id):
      return "/users/\(id)"
    case .getProfile:
      return "/user"
    case .getRecordBook:
      return "/user/record-book"
    case .getDiploma:
      return "/user/record-book/diploma"
    case .getGroup:
      return "/user/group"
    case .getSettings:
      return "/user/settings"
    case .updateSettings:
      return "/user/settings"
    }
  }

  var method: Method {
    switch self {
    case .auth:
      return .get
    case .getUser:
      return .get
    case .getProfile:
      return .get
    case .getRecordBook:
      return .get
    case .getDiploma:
      return .get
    case .getGroup:
      return .get
    case .getSettings:
      return .get
    case .updateSettings:
      return .put
    }
  }

  var sampleData: Data {
    return Data()
  }

  var task: Task {
    switch self {
    case .auth(let login, let password):
      return .requestParameters(
        parameters: ["login": login,
                     "password": password],
        encoding: URLEncoding.default
      )
    case .getUser:
      return .requestPlain
    case .getProfile:
      return .requestPlain
    case .getRecordBook:
      return .requestPlain
    case .getDiploma:
      return .requestPlain
    case .getGroup:
      return .requestPlain
    case .getSettings:
      return .requestPlain
    case .updateSettings(let settings):
      return .requestParameters(
        parameters: ["isPublicProfile": settings.isPublicProfile,
                     "isSearchJob": settings.isSearchJob,
                     "isShowRating": settings.isShowRating],
        encoding: JSONEncoding.default
      )
    }
  }

  var headers: [String: String]? {
    switch self {
    case .auth:
      return ["Content-Type": "application/json"]
    case .getUser:
      return ["Content-Type": "application/json"]
    case .getProfile:
      return ["Content-Type": "application/json",
              "Authorization": ProfileManager.shared.token]
    case .getRecordBook:
      return ["Content-Type": "application/json",
              "Authorization": ProfileManager.shared.token]
    case .getDiploma:
      return ["Content-Type": "application/json",
              "Authorization": ProfileManager.shared.token]
    case .getGroup:
      return ["Content-Type": "application/json",
              "Authorization": ProfileManager.shared.token]
    case .getSettings:
      return ["Content-Type": "application/json",
              "Authorization": ProfileManager.shared.token]
    case .updateSettings:
      return ["Content-Type": "application/json",
              "Authorization": ProfileManager.shared.token]
    }
  }

  var validationType: ValidationType {
    return .successCodes
  }
}
