//
//  RecordBook.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/1/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import Foundation

struct RecordBook: Codable {
    
    let number: String
    let averageMark: Double
    let semesters: [Semester]
    
}

struct Semester: Codable {
    
    let number: Int
    let averageMark: Double
    let marks: [Mark]
    
}

struct Mark: Codable {

    let subject: String
    let formOfControl: String
    let hours: Int?
    let mark: String?
    let date: TimeInterval?
    let teacher: String?
    let retakesCount: Int
    let statistic: SubjectStatistic?
    
}

struct SubjectStatistic: Codable {
    
    let averageMark: Double?
    let averageRetakes: Double?
    
}
