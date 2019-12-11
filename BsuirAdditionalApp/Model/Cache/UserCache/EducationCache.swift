//
//  EducationCache.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/11/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import Foundation

open class EducationCache: NSObject, NSCoding {

    open var faculty: String
    open var course: Int
    open var speciality: String
    open var group: String
    
    init(education: Education) {
        self.faculty = education.faculty
        self.course = education.course
        self.speciality = education.speciality
        self.group = education.group
    }
    
    public required init?(coder aDecoder: NSCoder) {
        self.faculty = aDecoder.decodeObject(forKey: "faculty") as! String
        self.course = aDecoder.decodeInteger(forKey: "course")
        self.speciality = aDecoder.decodeObject(forKey: "speciality") as! String
        self.group = aDecoder.decodeObject(forKey: "group") as! String
    }
    
    open func encode(with aCoder: NSCoder) {
        aCoder.encode(self.faculty, forKey: "faculty")
        aCoder.encode(self.course, forKey: "course")
        aCoder.encode(self.speciality, forKey: "speciality")
        aCoder.encode(self.group, forKey: "group")
    }
}


