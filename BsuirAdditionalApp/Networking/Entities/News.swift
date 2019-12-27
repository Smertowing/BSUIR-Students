//
//  News.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/1/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import UIKit

struct News: Codable {
  let id: Int
  let title: String
  let source: Source
  let content: String
  let publishedAt: TimeInterval
  let loadedAt: TimeInterval
  let url: String
  let urlToImage: String?
}

struct Source: Codable {
  let id: Int
  let type: NewsSourceType
  let name: String
}
