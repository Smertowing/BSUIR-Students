//
//  Group.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/1/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import Foundation

struct Group: Codable {
  let name: String
  let members: [GroupMate]
}

struct GroupMate: Codable {
  let role: String?
  let name: String
  let email: String?
  let phone: String?
}
