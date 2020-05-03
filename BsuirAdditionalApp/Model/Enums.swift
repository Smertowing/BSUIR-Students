//
//  Enums.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/1/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import Foundation

enum AuditoriumType: String, Codable {
  case lecture = "LESSON_LECTURE"
  case lab = "LESSON_LAB"
  case practice = "LESSON_PRACTICE"

  static let allValues = [lecture, lab, practice]
}

enum SortType: String {
  case asc = "ASC"
  case desc = "DESC"
}

enum FilterType: String {
  case numberic = "numberic"
  case string = "string"
  case date = "date"
}

enum ComparisonType: String {
  case equels = "EQ"
  case contains = "CT"
  case lessThan = "LT"
  case graterThan = "GT"
  case includes = "IN"
}

enum NetworkError: Error {
  case unknownError
  case connectionError
  case invalidCredentials
  case invalidRequest
  case notFound
  case invalidResponse
  case serverError
  case serverUnavailable
  case timeOut
  case unsuppotedURL
}

enum DataCacheKeys: String {
  case subscription = "subscription"
  case filter = "filter"
  case buildings = "buildings"
  case user = "user"
  case group = "group"
  case settings = "settings"
  case recordBook = "recordBook"
}

enum ProfileKeys: String {
  case isLogged = "isLogged"
  case token = "token"
  case deviceToken = "deviceToken"
}
