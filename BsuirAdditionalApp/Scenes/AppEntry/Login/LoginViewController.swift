//
//  LoginViewController.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/1/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let viewModel = LoginViewModel()
    
    @IBOutlet weak var bottomOffset: NSLayoutConstraint!
    @IBOutlet weak var topOffset: NSLayoutConstraint!
    
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var signinButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        signinButton.layer.cornerRadius = 5
        setupViewModel()
        loginField.addPaddingToTextField(rect: CGRect(x: 0, y: 0, width: 48, height: 0))
        loginField.attributedPlaceholder = NSAttributedString(string: "Login",
                                                              attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        passwordField.addPaddingToTextField(rect: CGRect(x: 0, y: 0, width: 48, height: 0))
        passwordField.attributedPlaceholder = NSAttributedString(string: "Password",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
    }
    
    private func setupViewModel() {
        viewModel.delegate = self
    }
    
    @IBAction func signinClicked(_ sender: Any) {
        signinButton.isEnabled = false
        signinButton.backgroundColor = UIColor.gray
        if let username = loginField.text, let password = passwordField.text, (username.trimmingCharacters(in: .whitespacesAndNewlines) != "") && (password.trimmingCharacters(in: .whitespacesAndNewlines) != "") {
            viewModel.auth(login: username, password: password)
        } else {
            showAlert(title: "Ошибка", message: "Некорректные данные в полях ввода") {
                self.signinButton.isEnabled = true
                self.signinButton.backgroundColor = AppColors.accentColor.uiColor()
            }
        }
    }
    
}

extension LoginViewController: LoginViewModelDelegate {
    
    func loggedIn() {
        signinButton.isEnabled = true
        signinButton.backgroundColor = AppColors.accentColor.uiColor()
        segueToAppllication()
    }
    
    func showError(error: NetworkError) {
        signinButton.isEnabled = true
        signinButton.backgroundColor = AppColors.accentColor.uiColor()
        showErrorAlert(error)
    }
    
}

extension LoginViewController  {
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            
            bottomOffset.constant = -keyboardSize.height
            topOffset.constant = -keyboardSize.height
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        bottomOffset.constant = 0
        topOffset.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
}

