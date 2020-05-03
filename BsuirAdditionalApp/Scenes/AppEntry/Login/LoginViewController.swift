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

  var spinner = UIActivityIndicatorView(style: .whiteLarge)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    hideKeyboardWhenTappedAround()
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    signinButton.layer.cornerRadius = 5
    signinButton.isEnabled = false
    signinButton.backgroundColor = UIColor.gray
    setupViewModel()
    loadSpinner()
    loginField.addPaddingToTextField(rect: CGRect(x: 0, y: 0, width: 48, height: 0))
    loginField.attributedPlaceholder = NSAttributedString(string: "Login",
                                                          attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
    loginField.addTarget(self, action: #selector(loginPrimaryAction), for: UIControl.Event.primaryActionTriggered)
    loginField.addTarget(self, action: #selector(checkSignIn), for: UIControl.Event.editingChanged)
    passwordField.addPaddingToTextField(rect: CGRect(x: 0, y: 0, width: 48, height: 0))
    passwordField.attributedPlaceholder = NSAttributedString(string: "Password",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
    passwordField.addTarget(self, action: #selector(passwordPrimaryAction), for: UIControl.Event.primaryActionTriggered)
    passwordField.addTarget(self, action: #selector(checkSignIn), for: UIControl.Event.editingChanged)
  }
  
  func loadSpinner() {
    spinner.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(spinner)
    spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
  }

  private func setupViewModel() {
    viewModel.delegate = self
  }

  @IBAction func signinClicked(_ sender: Any) {
    signinButton.isEnabled = false
    signinButton.backgroundColor = UIColor.gray
    if let username = loginField.text, let password = passwordField.text, (username.trimmingCharacters(in: .whitespacesAndNewlines) != "") && (password.trimmingCharacters(in: .whitespacesAndNewlines) != "") {
      viewModel.auth(login: username, password: password)
      spinner.startAnimating()
    } else {
      showAlert(title: "Ошибка".localized, message: "Некорректные данные в полях ввода".localized) {
        self.signinButton.isEnabled = true
        self.signinButton.backgroundColor = AppColors.accentColor.uiColor()
      }
    }
  }
  
  @objc func loginPrimaryAction(textField: UITextField) {
    passwordField.becomeFirstResponder()
  }
  
  @objc func passwordPrimaryAction(textField: UITextField) {
    signinClicked(self)
  }
  
  @objc func checkSignIn(textField: UITextField) {
    if !(loginField.text?.isEmpty ?? true) && !(passwordField.text?.isEmpty ?? true) {
      signinButton.isEnabled = true
      self.signinButton.backgroundColor = AppColors.accentColor.uiColor()
    } else {
      signinButton.isEnabled = false
      signinButton.backgroundColor = UIColor.gray
    }
  }
}

extension LoginViewController: LoginViewModelDelegate {
  func loggedIn() {
    spinner.stopAnimating()
    signinButton.isEnabled = true
    signinButton.backgroundColor = AppColors.accentColor.uiColor()
    segueToAppllication()
  }

  func showError(error: NetworkError) {
    spinner.stopAnimating()
    signinButton.isEnabled = true
    signinButton.backgroundColor = AppColors.accentColor.uiColor()
    showErrorAlert(error)
  }
}

extension LoginViewController {
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
