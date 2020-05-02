//
//  SubscriptionsCache.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 5/2/20.
//  Copyright © 2020 Kiryl Holubeu. All rights reserved.
//

import Foundation

open class SubscriptionsCache: NSObject, NSCoding {
  open var sources: [SourceCache]

  init(sources: [Source]) {
    self.sources = []
    for source in sources {
      self.sources.append(SourceCache(source: source))
    }
  }

  public required init?(coder aDecoder: NSCoder) {
    self.sources = aDecoder.decodeObject(forKey: "sources") as! [SourceCache]
  }

  open func encode(with aCoder: NSCoder) {
    aCoder.encode(self.sources, forKey: "sources")
  }
}

