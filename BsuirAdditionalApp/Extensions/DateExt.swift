//
//  DateExt.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/2/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import Foundation

extension Date {
  var newsFormat: String {
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = .autoupdatingCurrent
    dateFormatter.dateFormat = "dd MMMM HH:mm"
    return dateFormatter.string(from: self)
  }

  var auditDateFormat: String {
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = .autoupdatingCurrent
    dateFormatter.dateFormat = "dd.MM.yyyy"
    return dateFormatter.string(from: self)
  }

  var auditTimeFormat: String {
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = .autoupdatingCurrent
    dateFormatter.dateFormat = "HH:mm"
    return dateFormatter.string(from: self)
  }
}
