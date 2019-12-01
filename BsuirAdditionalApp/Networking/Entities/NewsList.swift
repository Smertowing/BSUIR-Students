//
//  NewsList.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/1/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import Foundation

struct NewsList: Codable {
    
    let page: Int
    let newsAtPage: Int
    let count: Int
    let news: [News]
    
}
