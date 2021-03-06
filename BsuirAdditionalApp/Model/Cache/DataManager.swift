//
//  DataManager.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/8/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import Foundation
import DataCache

final class DataManager {
  static let shared = DataManager()

  private init() {}

  var filter: FilterCache {
    get {
      return (DataCache.instance.readObject(forKey: DataCacheKeys.filter.rawValue) as? FilterCache ?? FilterCache(title: nil, content: nil, sources: [], sourcesInt: [], firstDate: nil, secondDate: nil))
    }
    set {
      DataCache.instance.clean(byKey: DataCacheKeys.filter.rawValue)
      DataCache.instance.write(object: newValue, forKey: DataCacheKeys.filter.rawValue)
    }
  }
  
  var subscriptions: SubscriptionsCache {
    get {
      return (DataCache.instance.readObject(forKey: DataCacheKeys.subscription.rawValue) as? SubscriptionsCache ?? SubscriptionsCache(sources: []))
    }
    set {
      DataCache.instance.clean(byKey: DataCacheKeys.subscription.rawValue)
      DataCache.instance.write(object: newValue, forKey: DataCacheKeys.subscription.rawValue)
    }
  }

  var buildings: BuildingsCache {
    get {
      return (DataCache.instance.readObject(forKey: DataCacheKeys.buildings.rawValue) as? BuildingsCache ?? BuildingsCache(buildings: []))
    }
    set {
      DataCache.instance.clean(byKey: DataCacheKeys.buildings.rawValue)
      DataCache.instance.write(object: newValue, forKey: DataCacheKeys.buildings.rawValue)
    }
  }

  var user: UserCache? {
    get {
      return (DataCache.instance.readObject(forKey: DataCacheKeys.user.rawValue) as? UserCache)
    }
    set {
      DataCache.instance.clean(byKey: DataCacheKeys.user.rawValue)
      if let value = newValue {
        DataCache.instance.write(object: value, forKey: DataCacheKeys.user.rawValue)
      }
    }
  }

  var group: GroupCache? {
    get {
      return (DataCache.instance.readObject(forKey: DataCacheKeys.group.rawValue) as? GroupCache)
    }
    set {
      DataCache.instance.clean(byKey: DataCacheKeys.group.rawValue)
      if let value = newValue {
        DataCache.instance.write(object: value, forKey: DataCacheKeys.group.rawValue)
      }
    }
  }

  var settings: SettingsCache? {
    get {
      return (DataCache.instance.readObject(forKey: DataCacheKeys.settings.rawValue) as? SettingsCache)
    }
    set {
      DataCache.instance.clean(byKey: DataCacheKeys.settings.rawValue)
      if let value = newValue {
        DataCache.instance.write(object: value, forKey: DataCacheKeys.settings.rawValue)
      }
    }
  }

  var recordBook: RecordBookCache? {
    get {
      return (DataCache.instance.readObject(forKey: DataCacheKeys.recordBook.rawValue) as? RecordBookCache)
    }
    set {
      DataCache.instance.clean(byKey: DataCacheKeys.recordBook.rawValue)
      if let value = newValue {
        DataCache.instance.write(object: value, forKey: DataCacheKeys.recordBook.rawValue)
      }
    }
  }

  func logout() {
    DataCache.instance.cleanAll()
  }
}
