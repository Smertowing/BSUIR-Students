//
//  LoginViewModel.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/1/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import Foundation

protocol LoginViewModelDelegate: class {
    
    func loggedIn()
    func showError(error: NetworkError)
    
}

final class LoginViewModel {
    
    weak var delegate: LoginViewModelDelegate?
    
    func auth(login: String, password: String) {
        NetworkingManager.iis.auth(login: login, password: password) { (answer) in
            switch answer {
            case .success(let response):
                ProfileManager.shared.token = response.token
                ProfileManager.shared.login()
                self.delegate?.loggedIn()
            case .failure(let error):
                self.delegate?.showError(error: error)
            }
        }
    }
    
}

