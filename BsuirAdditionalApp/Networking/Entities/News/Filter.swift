//
//  Filter.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 3/8/20.
//  Copyright © 2020 Kiryl Holubeu. All rights reserved.
//

import Foundation

struct Filter {
  let type: FilterType
  let comparison: ComparisonType
  let value: [Any]
  let field: String
}
