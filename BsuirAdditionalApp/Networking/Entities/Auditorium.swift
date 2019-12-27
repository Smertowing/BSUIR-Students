//
//  Auditorium.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/1/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import Foundation

struct Auditorium: Codable {
  let type: AuditoriumType
  let floor: Int
  let building: Int
  let name: String
}
