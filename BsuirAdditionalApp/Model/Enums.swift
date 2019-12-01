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
