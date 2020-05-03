//
//  GroupMemberCell.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/12/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import UIKit

class GroupMemberCell: UITableViewCell {
  @IBOutlet weak var contentTextView: UITextView!

  var mate: GroupMateCache!

  func set(_ mate: GroupMateCache?) {
    guard let mate = mate else {
      return
    }
    self.mate = mate
    contentTextView.text = ""
    contentTextView.text.append(mate.name)
    if let phone = mate.phone {
      contentTextView.text.append("\n\("Телефон".localized): \(phone)")
    }
    if let email = mate.email {
      contentTextView.text.append("\n\("Email".localized): \(email)")
    }
    if let role = mate.role {
      contentTextView.text.append("\n\(role)")
    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    // Configure the view for the selected state
  }
}
