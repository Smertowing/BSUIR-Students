//
//  NewsList.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/1/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import Foundation

struct NewsList: Codable {
  let totalPages: Int
  let page: Int
  let pageSize: Int
  let totalElements: Int
  let content: [News]
}
