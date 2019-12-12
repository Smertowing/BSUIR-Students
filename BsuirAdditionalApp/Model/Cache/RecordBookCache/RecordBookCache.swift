//
//  RecordBookCache.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/12/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import Foundation

open class RecordBookCache: NSObject, NSCoding {

    open var number: String
    open var averageMark: Double
    open var semesters: [SemesterCache]
    
    init(book: RecordBook) {
        self.number = book.number
        self.averageMark = book.averageMark
        self.semesters = []
        for sem in book.semesters {
            self.semesters.append(SemesterCache(sem: sem))
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        self.number = aDecoder.decodeObject(forKey: "number") as! String
        self.averageMark = aDecoder.decodeDouble(forKey: "averageMark")
        self.semesters = aDecoder.decodeObject(forKey: "semesters") as! [SemesterCache]
    }
    
    open func encode(with aCoder: NSCoder) {
        aCoder.encode(self.number, forKey: "number")
        aCoder.encode(self.averageMark, forKey: "averageMark")
        aCoder.encode(self.semesters, forKey: "semesters")
    }
    
}
