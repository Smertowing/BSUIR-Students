//
//  SettingsCache.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/11/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import Foundation

open class SettingsCache: NSObject, NSCoding {
  open var isPublicProfile: Bool
  open var isSearchJob: Bool
  open var isShowRating: Bool

  init(settings: UserSettings) {
    self.isPublicProfile = settings.isPublicProfile
    self.isSearchJob = settings.isSearchJob
    self.isShowRating = settings.isShowRating
  }

  public required init?(coder aDecoder: NSCoder) {
    self.isPublicProfile = aDecoder.decodeBool(forKey: "isPublicProfile")
    self.isSearchJob = aDecoder.decodeBool(forKey: "isSearchJob")
    self.isShowRating = aDecoder.decodeBool(forKey: "isShowRating")
  }

  open func encode(with aCoder: NSCoder) {
    aCoder.encode(self.isPublicProfile, forKey: "isPublicProfile")
    aCoder.encode(self.isSearchJob, forKey: "isSearchJob")
    aCoder.encode(self.isShowRating, forKey: "isShowRating")
  }
}
