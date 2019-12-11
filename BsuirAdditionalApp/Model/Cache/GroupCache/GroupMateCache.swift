//
//  GroupMateCache.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/12/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import Foundation

open class GroupMateCache: NSObject, NSCoding {

    open var role: String?
    open var name: String
    open var email: String?
    open var phone: String?
    
    init(mate: GroupMate) {
        self.role = mate.role
        self.name = mate.name
        self.email = mate.email
        self.phone = mate.phone
    }
    
    public required init?(coder aDecoder: NSCoder) {
        self.role = aDecoder.decodeObject(forKey: "role") as? String
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.email = aDecoder.decodeObject(forKey: "email") as? String
        self.phone = aDecoder.decodeObject(forKey: "phone") as? String
    }
    
    open func encode(with aCoder: NSCoder) {
        aCoder.encode(self.role, forKey: "role")
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.email, forKey: "email")
        aCoder.encode(self.phone, forKey: "phone")
    }
}
