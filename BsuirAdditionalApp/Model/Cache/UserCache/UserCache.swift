//
//  UserCache.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/11/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import Foundation

open class UserCache: NSObject, NSCoding {
  open var id: Int
  open var firstName: String
  open var lastName: String
  open var middleName: String
  open var birthDay: String
  open var photo: String?
  open var summary: String?
  open var rating: Int
  open var education: EducationCache
  open var skills: [SkillCache]
  open var references: [ReferenceCache]
  open var settings: SettingsCache

  init(user: User) {
    self.id = user.id
    self.firstName = user.firstName
    self.lastName = user.lastName
    self.middleName = user.middleName
    self.birthDay = user.birthDay
    self.photo = user.photo
    self.summary = user.summary
    self.rating = user.rating
    self.education = EducationCache(education: user.educationInfo)
    self.skills = []
    for skill in user.skills {
      self.skills.append(SkillCache(skill: skill))
    }
    self.references = []
    for reference in user.references {
      self.references.append(ReferenceCache(refer: reference))
    }
    self.settings = SettingsCache(settings: user.settings)
  }

  public required init?(coder aDecoder: NSCoder) {
    self.id = aDecoder.decodeInteger(forKey: "id")
    self.firstName = aDecoder.decodeObject(forKey: "firstName") as! String
    self.lastName = aDecoder.decodeObject(forKey: "lastName") as! String
    self.middleName = aDecoder.decodeObject(forKey: "middleName") as! String
    self.birthDay = aDecoder.decodeObject(forKey: "birthDay") as! String
    self.photo = aDecoder.decodeObject(forKey: "photo") as? String
    self.summary = aDecoder.decodeObject(forKey: "summary") as? String
    self.rating = aDecoder.decodeInteger(forKey: "rating")
    self.education = aDecoder.decodeObject(forKey: "education") as! EducationCache
    self.skills = aDecoder.decodeObject(forKey: "skills") as! [SkillCache]
    self.references = aDecoder.decodeObject(forKey: "references") as! [ReferenceCache]
    self.settings = aDecoder.decodeObject(forKey: "settings") as! SettingsCache
  }

  open func encode(with aCoder: NSCoder) {
    aCoder.encode(self.id, forKey: "id")
    aCoder.encode(self.firstName, forKey: "firstName")
    aCoder.encode(self.lastName, forKey: "lastName")
    aCoder.encode(self.middleName, forKey: "middleName")
    aCoder.encode(self.birthDay, forKey: "birthDay")
    aCoder.encode(self.photo, forKey: "photo")
    aCoder.encode(self.summary, forKey: "summary")
    aCoder.encode(self.rating, forKey: "rating")
    aCoder.encode(self.education, forKey: "education")
    aCoder.encode(self.skills, forKey: "skills")
    aCoder.encode(self.references, forKey: "references")
    aCoder.encode(self.settings, forKey: "settings")
  }
}
