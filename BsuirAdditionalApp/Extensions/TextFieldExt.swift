//
//  TextFieldExt.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/1/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import UIKit

extension UITextField {
    
    func addPaddingToTextField() {
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 48, height: 0))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
}
