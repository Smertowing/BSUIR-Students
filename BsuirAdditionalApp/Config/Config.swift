//
//  Config.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/1/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import Foundation

func infoPlistValue(for key: String) -> String {
    return Bundle.main.infoDictionary![key]! as! String
}

struct Config {
    
    static let apiUrl = infoPlistValue(for: "BaseUrl")
    
}
