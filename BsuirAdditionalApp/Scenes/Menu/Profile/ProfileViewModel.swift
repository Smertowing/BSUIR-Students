//
//  ProfileViewModel.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/12/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import UIKit

protocol ProfileViewModelDelegate: class {
  func refresh()
  func failed(with reason: NetworkError)
}

final class ProfileViewModel {
  weak var delegate: ProfileViewModelDelegate!

  private var currentUser: UserCache?

  var image: String? {
    return currentUser?.photo
  }

  var name: String {
    if let user = currentUser {
      return "\(user.firstName) \(user.lastName)"
    } else {
      return " "
    }
  }

  var mainInfo: String {
    if let user = currentUser {
      return "\(user.education.speciality), \(user.education.course) курс, \(user.education.faculty)\n Группа \(user.education.group)"
    } else {
      return " "
    }
  }

  var rating: Int {
    if let user = currentUser {
      return user.rating
    } else {
      return 0
    }
  }

  var summary: String {
    if let summary = currentUser?.summary {
      return summary
    } else {
      return " "
    }
  }

  var skills: String {
    if let user = currentUser {
      var result = ""
      for skill in user.skills {
        result.append("\(skill.name), ")
      }
      result.removeLast(2)
      return result
    } else {
      return " "
    }
  }

  var references: [String] {
    if let user = currentUser {
      var result: [String] = []
      for reference in user.references {
        result.append("\(reference.name) - \(reference.reference)")
      }
      return result
    } else {
      return []
    }
  }

  func getSavedUser() {
    if let savedUser = DataManager.shared.user {
      currentUser = savedUser
      self.delegate?.refresh()
    } else {
      fetchUser()
    }
  }

  func fetchUser() {
    NetworkingManager.iis.getProfile { (answer) in
      switch answer {
      case .success(let user):
        DataManager.shared.user = UserCache(user: user)
        self.getSavedUser()
      case .failure(let error):
        print(error)
      }
    }
  }
}
