//
//  UIImageExt.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 4/25/20.
//  Copyright © 2020 Kiryl Holubeu. All rights reserved.
//

import UIKit

extension UIImage {
  func resizeImage(scale: CGFloat) -> UIImage {
    let newSize = CGSize(width: self.size.width*scale, height: self.size.height*scale)
    let rect = CGRect(origin: CGPoint.zero, size: newSize)
    UIGraphicsBeginImageContext(newSize)
    self.draw(in: rect)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return newImage!
  }
}
