//
//  SemesterCache.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/12/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import Foundation

open class SemesterCache: NSObject, NSCoding {
  open var number: Int
  open var averageMark: Double
  open var marks: [MarkCache]

  init(sem: Semester) {
    self.number = sem.number
    self.averageMark = sem.averageMark
    self.marks = []
    for mark in sem.marks {
      self.marks.append(MarkCache(mark: mark))
    }
  }

  public required init?(coder aDecoder: NSCoder) {
    self.number = aDecoder.decodeInteger(forKey: "number")
    self.averageMark = aDecoder.decodeDouble(forKey: "averageMark")
    self.marks = aDecoder.decodeObject(forKey: "marks") as! [MarkCache]
  }

  open func encode(with aCoder: NSCoder) {
    aCoder.encode(self.number, forKey: "number")
    aCoder.encode(self.averageMark, forKey: "averageMark")
    aCoder.encode(self.marks, forKey: "marks")
  }
}
