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
    
    var buildings: BuildingsCache {
        get {
            return (DataCache.instance.readObject(forKey: DataCacheKeys.buildings.rawValue) as? BuildingsCache ?? BuildingsCache(buildings: []))
        }
        set {
            DataCache.instance.clean(byKey: DataCacheKeys.buildings.rawValue)
            DataCache.instance.write(object: newValue, forKey: DataCacheKeys.buildings.rawValue)
        }
    }
    
    func logout() {
        DataCache.instance.cleanAll()
    }
}

