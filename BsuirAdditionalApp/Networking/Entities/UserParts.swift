//
//  UserParts.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/1/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import Foundation

struct UserSkill: Codable {
  let id: Int
  let name: String
}

struct UserReference: Codable {
  let id: Int
  let name: String
  let reference: String
}

struct UserSettings: Codable {
  let isPublicProfile: Bool
  let isSearchJob: Bool
  let isShowRating: Bool
}
