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
            return userdefaults.bool(forKey: "isLogged")
        }
    }
    
    var token: String {
        get {
            return defaults.get("token") ?? ""
        }
        set {
            defaults.set(newValue, forKey: "token")
        }
    }
    
    func login() {
        userdefaults.set(true, forKey: "isLogged")
    }
    
    func logout() {
        defaults.clear()
        userdefaults.set(false, forKey: "isLogged")
    }
    
}
