//
//  MenuViewController.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/2/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import UIKit

class MenuViewController: UITableViewController {
  private let viewModel = MenuViewModel()

  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var photoImageView: UIImageView!

  override func viewDidLoad() {
    super.viewDidLoad()
    hideKeyboardWhenTappedAround()
    navigationItem.title = "Меню".localized
    navigationController?.navigationBar.isTranslucent = false
    tabBarController?.tabBar.isTranslucent = false
    setupViewModel()
    photoImageView.layer.cornerRadius = photoImageView.bounds.width / 2
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.view.isUserInteractionEnabled = true
    viewModel.fetchUser()
  }

  private func setupViewModel() {
    viewModel.delegate = self
    viewModel.getSavedUser()
  }

  func setupValues() {
    nameLabel.text = viewModel.name
    photoImageView.kf.setImage(with: URL(string: viewModel.image ?? ""), placeholder: #imageLiteral(resourceName: "photo_small"))
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    if indexPath.section == 2 {
      showLogoutConfirmationAlert()
    }
  }

  func showLogoutConfirmationAlert() {
    let alert = UIAlertController(title: nil, message: "Выйти из профиля?".localized, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "ОК".localized, style: .destructive) { _ in
      alert.dismiss(animated: true, completion: nil)
      self.logout()
    }
    let cancelAction = UIAlertAction(title: "Отмена".localized, style: .default) { _ in
      alert.dismiss(animated: true, completion: nil)
    }
    alert.addAction(cancelAction)
    alert.addAction(okAction)
    self.present(alert, animated: true, completion: nil)
  }

  func logout() {
    viewModel.signOut()
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let startViewController = storyboard.instantiateViewController(withIdentifier: "firstScreen")
    UIApplication.shared.keyWindow?.rootViewController = startViewController
  }
}

extension MenuViewController: MenuViewModelDelegate {
  func refresh() {
    setupValues()
  }

  func failed(with reason: NetworkError) {
    self.showErrorAlert(reason)
  }
}
