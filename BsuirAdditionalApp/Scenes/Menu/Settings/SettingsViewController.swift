//
//  SettingsViewController.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/12/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import UIKit
import MessageUI

class SettingsViewController: UIViewController, MFMailComposeViewControllerDelegate {
  private let viewModel = SettingsViewModel()

  @IBOutlet weak var ratingSwitch: UISwitch!
  @IBOutlet weak var profileSwitch: UISwitch!
  @IBOutlet weak var workSwitch: UISwitch!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  var spinner = UIActivityIndicatorView(style: .whiteLarge)

  let supportServiceEmails = ["kiryl.co@gmail.com", "sasha.pankratiew@gmail.com"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    hideKeyboardWhenTappedAround()
    navigationItem.title = "Настройки".localized
    navigationController?.navigationBar.isTranslucent = false
    tabBarController?.tabBar.isTranslucent = false
    loadSpinner()
    setupViewModel()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.view.isUserInteractionEnabled = true
    viewModel.fetchSettings()
  }

  private func setupViewModel() {
    viewModel.delegate = self
    viewModel.getSavedSettings()
  }

  func loadSpinner() {
    spinner.translatesAutoresizingMaskIntoConstraints = false
    spinner.startAnimating()
    view.addSubview(spinner)
    spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    spinner.startAnimating()
  }

  func setupValues() {
    ratingSwitch.isEnabled = true
    profileSwitch.isEnabled = true
    workSwitch.isEnabled = true
    activityIndicator.stopAnimating()
    ratingSwitch.isOn = viewModel.isRating
    profileSwitch.isOn = viewModel.isProfile
    workSwitch.isOn = viewModel.isWork
  }

  @IBAction func switchChanged(_ sender: Any) {
    ratingSwitch.isEnabled = false
    profileSwitch.isEnabled = false
    workSwitch.isEnabled = false
    activityIndicator.startAnimating()
    viewModel.setNewSettings(isProfile: profileSwitch.isOn, isRatings: ratingSwitch.isOn, isWork: workSwitch.isOn)
  }
  @IBAction func reportProblem(_ sender: Any) {
    if MFMailComposeViewController.canSendMail() {
        let mail = MFMailComposeViewController()
        mail.mailComposeDelegate = self
        mail.setToRecipients(supportServiceEmails)
        mail.setSubject("[iOS] BSUIR Student")
        mail.setMessageBody("\(UIDevice.current.type.rawValue), \(UIDevice.current.systemVersion), BSUIR Student v.\(Bundle.main.versionNumber)", isHTML: true)

        present(mail, animated: true)
    } else {
      showAlert(title: "Неудача".localized, message: "Невозможно отправить электронное сообщение. Проверьте доступность своей почты".localized)
    }
  }
}

extension SettingsViewController: SettingsViewModelDelegate {
  func refresh() {
    spinner.stopAnimating()
    setupValues()
  }

  func failed(with reason: NetworkError) {
    spinner.stopAnimating()
    self.showErrorAlert(reason) {
      self.setupValues()
    }
  }
}
