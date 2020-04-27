//
//  NewsSubscriptionsTableViewCell.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 4/27/20.
//  Copyright © 2020 Kiryl Holubeu. All rights reserved.
//

import UIKit

class NewsSubscriptionsTableViewCell: UITableViewCell {
  var currentSource: Source!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var subscribeSwitch: UISwitch!
  
  func set(_ source: Source?) {
    guard let source = source else {
      return
    }
    currentSource = source
    nameLabel.text = source.name
    subscribeSwitch.isOn = source.subscribed ?? false
  }
  
  @IBAction func onSubsribeChange(_ sender: Any) {
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
