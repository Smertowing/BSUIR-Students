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
  @IBOutlet weak var teacherLabel: UILabel!
  @IBOutlet weak var markLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var retakesLabel: UILabel!
  @IBOutlet weak var averageMarkLabel: UILabel!
  @IBOutlet weak var timeLabel: UILabel!
  @IBOutlet weak var averageRetakesLabel: UILabel!

  var currentMark: MarkCache!

  func set(_ mark: MarkCache?) {
    guard let mark = mark else {
      subjectLabel.text = "–"
      teacherLabel.text = "–"
      markLabel.text = "–"
      dateLabel.text = "–"
      retakesLabel.text = "–"
      averageMarkLabel.text = "–"
      timeLabel.text = "–"
      averageRetakesLabel.text = "–"
      return
    }
    self.currentMark = mark

    subjectLabel.text = "\(mark.subject) – \(mark.formOfControl)"

    if let teacher = mark.teacher {
      teacherLabel.text = teacher
    } else {
      teacherLabel.text = "–"
    }
    if let mark = mark.mark {
      markLabel.text = mark
    } else {
      markLabel.text = "–"
    }
    if let dateInterval = mark.date {
      dateLabel.text = dateInterval
    } else {
      dateLabel.text = "–"
    }
    retakesLabel.text = "\(mark.retakesCount)"
    if let averageMark = mark.statistics?.averageMark {
      averageMarkLabel.text = String(format: "%.2f", averageMark)
    } else {
      averageMarkLabel.text = "–"
    }
    if let hours = mark.hours {
      timeLabel.text = "\(hours)"
    } else {
      timeLabel.text = "–"
    }
    if let averageRetakes = mark.statistics?.averageRetakes {
      averageRetakesLabel.text = String(format: "%.2f", averageRetakes)
    } else {
      averageRetakesLabel.text = "–"
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
