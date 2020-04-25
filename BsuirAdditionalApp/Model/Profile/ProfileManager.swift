//
//  ProfileManager.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/1/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import Foundation

final class ProfileManager {
  static let shared = ProfileManager()

  private let userdefaults = UserDefaults.standard

  private init() { }

  var isAuthenticated: Bool {
    get {
      return userdefaults.bool(forKey: ProfileKeys.isLogged.rawValue)
    }
  }

  var token: String {
    get {
      return userdefaults.string(forKey: ProfileKeys.token.rawValue) ?? ""
    }
    set {
      userdefaults.set(newValue, forKey: ProfileKeys.token.rawValue)
    }
  }

  func login() {
    userdefaults.set(true, forKey: ProfileKeys.isLogged.rawValue)
  }

  func logout() {
    userdefaults.set(nil, forKey: ProfileKeys.token.rawValue)
    userdefaults.set(false, forKey: ProfileKeys.isLogged.rawValue)
  }
}
