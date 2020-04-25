//
//  FilterCache.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/8/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import Foundation

open class FilterCache: NSObject, NSCoding {
  open var title: String?
  open var content: String?
  open var sources: [String]
  open var sourcesInt: [Int]
  open var firstDate: Date?
  open var secondDate: Date?

  init(title: String?, content: String?, sources: [String], sourcesInt: [Int], firstDate: Date?, secondDate: Date?) {
    if title?.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
      self.title = title
    } else {
      self.title = nil
    }
    if content?.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
      self.content = content
    } else {
      self.content = nil
    }
    self.sources = []
    for source in sources {
      self.sources.append(source)
    }
    self.sourcesInt = []
    for sourceInt in sourcesInt {
      self.sourcesInt.append(sourceInt)
    }
    self.firstDate = firstDate
    self.secondDate = secondDate
  }

  public required init?(coder aDecoder: NSCoder) {
    self.title = aDecoder.decodeObject(forKey: "title") as? String
    self.content = aDecoder.decodeObject(forKey: "content") as? String
    self.sources = aDecoder.decodeObject(forKey: "sources") as! [String]
    self.sourcesInt = aDecoder.decodeObject(forKey: "sourcesInt") as! [Int]
    self.firstDate = aDecoder.decodeObject(forKey: "firstDate") as? Date
    self.secondDate = aDecoder.decodeObject(forKey: "secondDate") as? Date
  }

  open func encode(with aCoder: NSCoder) {
    aCoder.encode(self.title, forKey: "title")
    aCoder.encode(self.content, forKey: "content")
    aCoder.encode(self.sources, forKey: "sources")
    aCoder.encode(self.sourcesInt, forKey: "sourcesInt")
    aCoder.encode(self.firstDate, forKey: "firstDate")
    aCoder.encode(self.secondDate, forKey: "secondDate")
  }
}
