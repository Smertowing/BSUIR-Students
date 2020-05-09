//
//  BundleExt.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 5/9/20.
//  Copyright © 2020 Kiryl Holubeu. All rights reserved.
//

import Foundation

extension Bundle {
    
    var versionNumber: String {
        return (infoDictionary?["CFBundleShortVersionString"] as? String) ?? "1.0"
    }

    var buildNumber: String {
        return (infoDictionary?["CFBundleVersion"] as? String) ?? "0"
    }
    
}
