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

enum NewsSourceType: String, Codable {
    case fksis = "FKSIS"
    case bsuir = "BSUIR"
    case fic = "FIC"
    case fitu = "FITU"
    case fre = "FRE"
    case ief = "IEF"
    case other = "OTHER"
    
    static let allValues = [fksis, bsuir, fic, fitu, fre, ief, other]
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
    case filter = "filter"
    case buildings = "buildings"
    case user = "user"
    case group = "group"
    case settings = "settings"
}

enum ProfileKeys: String {
    case isLogged = "isLogged"
    case token = "token"
}
