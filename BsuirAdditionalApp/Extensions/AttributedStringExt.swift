//
//  AttributedString.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/8/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import UIKit

extension NSAttributedString {
  func attributedStringWithResizedImages(with maxWidth: CGFloat) -> NSAttributedString {
    let text = NSMutableAttributedString(attributedString: self)
    text.enumerateAttribute(NSAttributedString.Key.attachment, in: NSRange(location: 0, length: text.length), options: .init(rawValue: 0), using: { (value, range, _) in
      if let attachement = value as? NSTextAttachment {
        let image = attachement.image(forBounds: attachement.bounds, textContainer: NSTextContainer(), characterIndex: range.location)!
        if image.size.width > maxWidth {
          let newImage = image.resizeImage(scale: maxWidth/image.size.width)
          let newAttribut = NSTextAttachment()
          newAttribut.image = newImage
          text.addAttribute(NSAttributedString.Key.attachment, value: newAttribut, range: range)
        }
      }
    })
    return text
  }
}

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
