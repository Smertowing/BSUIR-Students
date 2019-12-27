//
//  ProfileManager.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/1/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import Foundation
import KeychainSwift

final class ProfileManager {
  static let shared = ProfileManager()

  private let defaults = KeychainSwift()
  private let userdefaults = UserDefaults.standard

  private init() { }

  var isAuthenticated: Bool {
    get {
      return userdefaults.bool(forKey: ProfileKeys.isLogged.rawValue)
    }
  }

  var token: String {
    get {
      return defaults.get(ProfileKeys.token.rawValue) ?? ""
    }
    set {
      defaults.set(newValue, forKey: ProfileKeys.token.rawValue)
    }
  }

  func login() {
    userdefaults.set(true, forKey: ProfileKeys.isLogged.rawValue)
  }

  func logout() {
    defaults.clear()
    userdefaults.set(false, forKey: ProfileKeys.isLogged.rawValue)
  }
}
