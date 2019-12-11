//
//  GroupCache.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/12/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import Foundation

open class GroupCache: NSObject, NSCoding {

    open var name: String
    open var members: [GroupMateCache]
    
    init(group: Group) {
        self.name = group.name
        self.members = []
        for member in group.members {
            self.members.append(GroupMateCache(mate: member))
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.members = aDecoder.decodeObject(forKey: "members") as! [GroupMateCache]
    }
    
    open func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.members, forKey: "members")
    }
}
