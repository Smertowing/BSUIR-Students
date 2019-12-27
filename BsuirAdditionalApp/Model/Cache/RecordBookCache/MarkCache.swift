//
//  MarkCache.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/12/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import Foundation

open class MarkCache: NSObject, NSCoding {
  open var subject: String
  open var formOfControl: String
  open var hours: Int?
  open var mark: String?
  open var date: TimeInterval?
  open var teacher: String?
  open var retakesCount: Int
  open var statistics: SubjectStatisticsCache?

  init(mark: Mark) {
    self.subject = mark.subject
    self.formOfControl = mark.formOfControl
    self.hours = mark.hours
    self.mark = mark.mark
    self.date = mark.date
    self.teacher = mark.teacher
    self.retakesCount = mark.retakesCount
    if let stats = mark.statistic {
      self.statistics = SubjectStatisticsCache(stats: stats)
    }
  }

  public required init?(coder aDecoder: NSCoder) {
    self.subject = aDecoder.decodeObject(forKey: "subject") as! String
    self.formOfControl = aDecoder.decodeObject(forKey: "formOfControl") as! String
    self.hours = aDecoder.decodeObject(forKey: "hours") as? Int
    self.mark = aDecoder.decodeObject(forKey: "mark") as? String
    self.date = aDecoder.decodeObject(forKey: "date") as? TimeInterval
    self.teacher = aDecoder.decodeObject(forKey: "teacher") as? String
    self.retakesCount = aDecoder.decodeInteger(forKey: "retakesCount")
    self.statistics = aDecoder.decodeObject(forKey: "statistics") as? SubjectStatisticsCache
  }

  open func encode(with aCoder: NSCoder) {
    aCoder.encode(self.subject, forKey: "subject")
    aCoder.encode(self.formOfControl, forKey: "formOfControl")
    aCoder.encode(self.hours, forKey: "hours")
    aCoder.encode(self.mark, forKey: "mark")
    aCoder.encode(self.date, forKey: "date")
    aCoder.encode(self.teacher, forKey: "teacher")
    aCoder.encode(self.retakesCount, forKey: "retakesCount")
    aCoder.encode(self.statistics, forKey: "statistics")
  }
}
