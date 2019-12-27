//
//  ColorTheme.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/1/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import UIKit



enum AppColors {
  static var primaryColor = UIColor(named: "PrimaryColor")?.schemeColor() ?? #colorLiteral(red: 0.160784319, green: 0.160784319, blue: 0.160784319, alpha: 1).schemeColor()
  static var accentColor = UIColor(named: "AccentColor")?.schemeColor() ?? #colorLiteral(red: 0.3647058824, green: 0.7137254902, blue: 0.6117647059, alpha: 1).schemeColor()
  static var accentLightColor = UIColor(named: "AccentLightColor")?.schemeColor() ?? #colorLiteral(red: 0.5830394254, green: 0.7499524889, blue: 0.6939845453, alpha: 1).schemeColor()
  
  static var subtextColor = UIColor(named: "SubtextColor")?.schemeColor() ?? #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1).schemeColor()
  static var textColor = UIColor(named: "TextColor")?.schemeColor() ?? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).schemeColor()
  static var textFieldColor = UIColor(named: "TextFieldColor")?.schemeColor() ?? #colorLiteral(red: 0.1843137255, green: 0.1843137255, blue: 0.1843137255, alpha: 1).schemeColor()
  
  static var barsColor = UIColor(named: "BarsColor")?.schemeColor() ?? #colorLiteral(red: 0.1137254902, green: 0.1137254902, blue: 0.1137254902, alpha: 1).schemeColor()
  static var backgroundColor = UIColor(named: "BackgroundColor")?.schemeColor() ?? #colorLiteral(red: 0.1137254902, green: 0.1137254902, blue: 0.1137254902, alpha: 1).schemeColor()
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
