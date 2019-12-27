//
//  BuildingsCache.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/8/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import Foundation

open class BuildingsCache: NSObject, NSCoding {
  open var buildings: [BuildingCache]

  init(buildings: [Building]) {
    self.buildings = []
    for building in buildings {
      self.buildings.append(BuildingCache(building: building))
    }
  }

  public required init?(coder aDecoder: NSCoder) {
    self.buildings = aDecoder.decodeObject(forKey: "buildings") as! [BuildingCache]
  }

  open func encode(with aCoder: NSCoder) {
    aCoder.encode(self.buildings, forKey: "buildings")
  }
}
