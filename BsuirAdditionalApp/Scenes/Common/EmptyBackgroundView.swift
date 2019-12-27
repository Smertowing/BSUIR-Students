//
//  EmptyBackgroundView.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/2/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import UIKit

class EmptyBackgroundView: UIView {
  class func instanceFromNib() -> UIView {
    return UINib(nibName: "EmptyBackgroundView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? UIView ?? UIView()
  }
}
