//
//  UIViewControllerExt.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/1/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import UIKit

extension UIViewController {
  func hideKeyboardWhenTappedAround() {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
  }

  @objc func dismissKeyboard() {
    view.endEditing(true)
  }

  func showAlert(title: String, message: String, action: (() -> Void)? = nil) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "ОК".localized, style: UIAlertAction.Style.default) { _ in
      if let action = action {
        action()
      }
    })
    self.present(alert, animated: true, completion: nil)
  }

  func showErrorAlert(_ error: NetworkError, action: (() -> Void)? = nil) {
    switch error {
    case .unknownError:
      self.showAlert(title: "Ошибка".localized, message: "Произошла неизвестная ошибка".localized, action: action)
    case .connectionError:
      self.showAlert(title: "Ошибка".localized, message: "Нет соединения с интернетом".localized, action: action)
    case .invalidCredentials:
      self.showAlert(title: "Ошибка".localized, message: "Нет прав доступа, проверьте валидность своего аккаунта или заново авторизуйтесь".localized, action: action)
    case .invalidRequest:
      self.showAlert(title: "Ошибка".localized, message: "Неверные данные".localized, action: action)
    case .notFound:
      self.showAlert(title: "Ошибка".localized, message: "Не найдено".localized, action: action)
    case .invalidResponse:
      self.showAlert(title: "Ошибка".localized, message: "Неправильное поведение сервиса".localized, action: action)
    case .serverError:
      self.showAlert(title: "Ошибка".localized, message: "Ошибка сервера".localized, action: action)
    case .serverUnavailable:
      self.showAlert(title: "Ошибка".localized, message: "Сервис недоступен".localized, action: action)
    case .timeOut:
      self.showAlert(title: "Ошибка".localized, message: "Время ожидания истекло".localized, action: action)
    default:
      self.showAlert(title: "Ошибка".localized, message: "Как это могло произойти?".localized, action: action)
    }
  }

  func segueToAppllication() {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    let mainTabViewController = storyBoard.instantiateViewController(withIdentifier: "mainTabVC") as! UITabBarController
    appDelegate.window?.rootViewController?.dismiss(animated: true, completion: nil)
    appDelegate.window?.rootViewController = mainTabViewController
  }

  func segueToStartScreen() {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    let startController = storyBoard.instantiateViewController(withIdentifier: "loginVC") as! LoginViewController
    appDelegate.window?.rootViewController?.dismiss(animated: true, completion: nil)
    appDelegate.window?.rootViewController = startController
  }
}
