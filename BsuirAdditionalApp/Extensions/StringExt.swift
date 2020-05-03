//
//  AttributedString.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/8/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import UIKit

extension String {
  func defaultDate()-> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
    return dateFormatter.date(from: self)
  }
  

  var localized: String {
    return NSLocalizedString(self, comment: "")
  }
}


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
