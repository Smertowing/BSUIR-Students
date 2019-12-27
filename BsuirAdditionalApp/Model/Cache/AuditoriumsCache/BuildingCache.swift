//
//  BuildingCache.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/8/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import Foundation

open class BuildingCache: NSObject, NSCoding {
  open var name: Int
  open var floor: [Int]

  init(building: Building) {
    self.name = building.name
    self.floor = []
    for floor in building.floors {
      self.floor.append(floor)
    }
  }

  public required init?(coder aDecoder: NSCoder) {
    self.name = aDecoder.decodeInteger(forKey: "name")
    self.floor = aDecoder.decodeObject(forKey: "floor") as! [Int]
  }

  open func encode(with aCoder: NSCoder) {
    aCoder.encode(self.name, forKey: "name")
    aCoder.encode(self.floor, forKey: "floor")
  }
}
