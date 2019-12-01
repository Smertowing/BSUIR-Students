//
//  TextFieldExt.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/1/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import UIKit

extension UITextField {
    
    func addPaddingToTextField(rect: CGRect) {
        let paddingView: UIView = UIView(frame: rect)
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
}
