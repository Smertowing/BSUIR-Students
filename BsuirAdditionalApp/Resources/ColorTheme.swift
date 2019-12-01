//
//  ColorTheme.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/1/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import UIKit

enum AppColors {
    
    static let primaryColor = #colorLiteral(red: 0.1607843137, green: 0.1607843137, blue: 0.1607843137, alpha: 1).schemeColor()
    static let accentColor = #colorLiteral(red: 0.3647058824, green: 0.7137254902, blue: 0.6117647059, alpha: 1).schemeColor()
    static let textFieldColor = #colorLiteral(red: 0.1843137255, green: 0.1843137255, blue: 0.1843137255, alpha: 1).schemeColor()
    static let barsColor = #colorLiteral(red: 0.1139291424, green: 0.1139291424, blue: 0.1139291424, alpha: 1).schemeColor()
}

struct SchemeColor {
    
    let color: UIColor
    
    func uiColor() -> UIColor {
        return color
    }
    
    func cgColor() -> CGColor {
        return color.cgColor
    }
}

extension UIColor {
    
    func schemeColor() -> SchemeColor {
        return SchemeColor(color: self)
    }
    
}


