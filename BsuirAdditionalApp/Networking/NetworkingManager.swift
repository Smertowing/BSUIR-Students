//
//  NetworkingManager.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/1/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import Moya

final class NetworkingManager {
  private init() {}

  static let auditoriums = AuditoriumsAdapter()
  static let news = NewsAdapter()
  static let iis = IISAdapter()
  static let files = FilesAdapter()
}
