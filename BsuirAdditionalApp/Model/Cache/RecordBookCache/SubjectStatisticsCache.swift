//
//  SubjectStatisticsCache.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/12/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import Foundation

open class SubjectStatisticsCache: NSObject, NSCoding {
  open var averageMark: Double?
  open var averageRetakes: Double?

  init(stats: SubjectStatistic) {
    self.averageMark = stats.averageMark
    self.averageRetakes = stats.averageRetakes
  }

  public required init?(coder aDecoder: NSCoder) {
    self.averageMark = aDecoder.decodeObject(forKey: "averageMark") as? Double
    self.averageRetakes = aDecoder.decodeObject(forKey: "averageRetakes") as? Double
  }

  open func encode(with aCoder: NSCoder) {
    aCoder.encode(self.averageMark, forKey: "averageMark")
    aCoder.encode(self.averageRetakes, forKey: "averageRetakes")
  }
}
