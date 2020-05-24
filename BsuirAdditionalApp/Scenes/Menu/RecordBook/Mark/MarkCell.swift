//
//  MarkCell.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/12/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import UIKit

class MarkCell: UITableViewCell {
  @IBOutlet weak var subjectLabel: UILabel!
  @IBOutlet weak var markLabel: UILabel!

  var currentMark: MarkCache!

  func set(_ mark: MarkCache?) {
    guard let mark = mark else {
      subjectLabel.text = "–"
      markLabel.text = "–"
      return
    }
    self.currentMark = mark

    subjectLabel.text = "\(mark.subject)"

    if let mark = mark.mark {
      markLabel.text = mark
    } else {
      markLabel.text = "–"
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
