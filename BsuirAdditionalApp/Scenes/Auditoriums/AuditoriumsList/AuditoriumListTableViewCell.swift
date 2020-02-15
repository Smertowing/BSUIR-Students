//
//  AuditoriumListTableViewCell.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/9/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import UIKit
import Kingfisher

class AuditoriumListTableViewCell: UITableViewCell {
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var subNameLabel: UILabel!

  var currentAuditorium: Auditorium!

  func set(_ auditorium: Auditorium?) {
    guard let auditorium = auditorium else {
      return
    }
    self.currentAuditorium = auditorium
    nameLabel.text = "\(currentAuditorium.name)-\(currentAuditorium.building)"
    switch currentAuditorium.type {
    case .lecture:
      subNameLabel.text = "Лекционный зал"
    case .lab:
      subNameLabel.text = "Лабораторные занятия"
    case .practice:
      subNameLabel.text = "Практические занятия"
    @unknown default:
      subNameLabel.text = "Где я?"
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
