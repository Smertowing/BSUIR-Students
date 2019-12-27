//
//  ReferenceCache.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/11/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import Foundation

open class ReferenceCache: NSObject, NSCoding {
  open var id: Int
  open var name: String
  open var reference: String

  init(refer: UserReference) {
    self.id = refer.id
    self.name = refer.name
    self.reference = refer.reference
  }

  public required init?(coder aDecoder: NSCoder) {
    self.id = aDecoder.decodeInteger(forKey: "id")
    self.name = aDecoder.decodeObject(forKey: "name") as! String
    self.reference = aDecoder.decodeObject(forKey: "reference") as! String
  }

  open func encode(with aCoder: NSCoder) {
    aCoder.encode(self.id, forKey: "id")
    aCoder.encode(self.name, forKey: "name")
    aCoder.encode(self.reference, forKey: "reference")
  }
}
