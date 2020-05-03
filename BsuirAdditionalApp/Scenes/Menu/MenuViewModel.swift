//
//  MenuViewModel.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/2/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import UIKit

protocol MenuViewModelDelegate: class {
  func refresh()
  func failed(with reason: NetworkError)
}

final class MenuViewModel {
  weak var delegate: MenuViewModelDelegate!

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
  
  func signOut() {
    NetworkingManager.notifications.unsubscribe(with: ProfileManager.shared.deviceToken) { _ in }
    DataManager.shared.logout()
    ProfileManager.shared.logout()
  }
}
