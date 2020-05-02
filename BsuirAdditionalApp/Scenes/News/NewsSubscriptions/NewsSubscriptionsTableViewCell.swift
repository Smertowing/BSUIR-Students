//
//  NewsSubscriptionsTableViewCell.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 4/27/20.
//  Copyright © 2020 Kiryl Holubeu. All rights reserved.
//

import UIKit

class NewsSubscriptionsTableViewCell: UITableViewCell {
  var currentSource: SourceCache!
  private var onChange: (Bool) -> Void = { _ in }
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var subscribeSwitch: UISwitch!
  
  func set(_ source: SourceCache?, onChange: @escaping (Bool) -> Void) {
    self.onChange = onChange
    guard let source = source else {
      return
    }
    currentSource = source
    nameLabel.text = source.name
    subscribeSwitch.isOn = source.subscribed
  }
  
  @IBAction func onValueChanged(_ sender: UISwitch) {
    onChange(sender.isOn)
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
