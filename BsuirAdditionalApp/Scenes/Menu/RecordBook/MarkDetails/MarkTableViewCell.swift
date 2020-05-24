//
//  MarkTableViewCell.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 5/24/20.
//  Copyright © 2020 Kiryl Holubeu. All rights reserved.
//

import UIKit

class MarkTableViewCell: UITableViewCell {

  @IBOutlet weak var valueLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }

  func set(_ value: String) {
    valueLabel.text = value
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }

}
