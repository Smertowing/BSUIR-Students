//
//  User.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/1/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import Foundation

struct User: Codable {

    let id: Int
    let firstName: String
    let lastName: String
    let middleName: String
    let birthDay: TimeInterval
    let photo: String?
    let summary: String?
    let rating: Int
    let education: Education
    let skills: [UserSkill]
    let references: [UserReference]
    let settings: UserSettings
    
}

struct Education: Codable {
    
    let faculty: String
    let course: Int
    let speciality: String
    let group: String
    
}
