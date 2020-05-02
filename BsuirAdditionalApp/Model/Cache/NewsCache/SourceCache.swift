//
//  SourceCache.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 5/2/20.
//  Copyright © 2020 Kiryl Holubeu. All rights reserved.
//

import Foundation

open class SourceCache: NSObject, NSCoding {
  open var id: Int
  open var alias: String
  open var type: String
  open var name: String
  open var subscribed: Bool

  init(source: Source) {
    self.id = source.id
    self.alias = source.alias
    self.type = source.type
    self.name = source.name
    self.subscribed = source.subscribed ?? false
  }

  public required init?(coder aDecoder: NSCoder) {
    self.id = aDecoder.decodeInteger(forKey: "id")
    self.alias = aDecoder.decodeObject(forKey: "alias") as! String
    self.type = aDecoder.decodeObject(forKey: "type") as! String
    self.name = aDecoder.decodeObject(forKey: "name") as! String
    self.subscribed = aDecoder.decodeBool(forKey: "subscribed")
  }

  open func encode(with aCoder: NSCoder) {
    aCoder.encode(self.id, forKey: "id")
    aCoder.encode(self.alias, forKey: "alias")
    aCoder.encode(self.type, forKey: "type")
    aCoder.encode(self.name, forKey: "name")
    aCoder.encode(self.subscribed, forKey: "subscribed")
  }
}

