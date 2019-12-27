//
//  SkillCache.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/11/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import Foundation

open class SkillCache: NSObject, NSCoding {
  open var id: Int
  open var name: String

  init(skill: UserSkill) {
    self.id = skill.id
    self.name = skill.name
  }

  public required init?(coder aDecoder: NSCoder) {
    self.id = aDecoder.decodeInteger(forKey: "id")
    self.name = aDecoder.decodeObject(forKey: "name") as! String
  }

  open func encode(with aCoder: NSCoder) {
    aCoder.encode(self.id, forKey: "id")
    aCoder.encode(self.name, forKey: "name")
  }
}
