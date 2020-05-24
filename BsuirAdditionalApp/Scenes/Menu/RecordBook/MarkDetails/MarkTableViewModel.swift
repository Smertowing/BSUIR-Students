//
//  MarkTableViewModel.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 5/24/20.
//  Copyright © 2020 Kiryl Holubeu. All rights reserved.
//

import UIKit

protocol MarkTableViewModelDelegate: class {
  func reloadContent()
}

final class MarkTableViewModel {
  weak var delegate: MarkTableViewModelDelegate?

  private var currentMark: MarkCache!

  func setCurrentMark(with mark: MarkCache) {
    currentMark = mark
  }
  
  var numberOfRows: Int {
    return MarkFields.allCases.count
  }
  
  func name(of index: Int) -> String {
    return MarkFields.allCases[index].rawValue.localized
  }
  
  func value(of indexPath: IndexPath) -> String {
    switch MarkFields.allCases[indexPath.section] {
    case .subject:
      return "\(currentMark.subject) – \(currentMark.formOfControl)"
    case .mark:
      if let mark = currentMark.mark {
        return mark
      } else {
        return "–"
      }
    case .teacher:
      if let teacher = currentMark.teacher {
        return teacher
      } else {
        return "–"
      }
    case .retakes:
      return "\(currentMark.retakesCount)"
    case .avRetakes:
      if let averageRetakes = currentMark.statistics?.averageRetakes {
        return String(format: "%.2f", averageRetakes)
      } else {
        return "–"
      }
    case .studyHours:
      if let hours = currentMark.hours {
        return "\(hours)"
      } else {
        return "–"
      }
    case .date:
      if let dateInterval = currentMark.date {
        return dateInterval
      } else {
        return "–"
      }
    case .avMark:
      if let averageMark = currentMark.statistics?.averageMark {
        return String(format: "%.2f", averageMark)
      } else {
        return "–"
      }
    }
  }
  
}


