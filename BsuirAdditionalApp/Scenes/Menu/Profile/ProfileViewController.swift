//
//  ProfileViewController.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/12/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import UIKit
import Cosmos

class ProfileViewController: UIViewController {
  private let viewModel = ProfileViewModel()
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var photoImageView: UIImageView!
  @IBOutlet weak var ratingView: CosmosView!
  @IBOutlet weak var mainInfoLabel: UILabel!
  @IBOutlet weak var summaryLabel: UILabel!
  @IBOutlet weak var skillsLabel: UILabel!
  @IBOutlet weak var referencesTextView: UITextView!
  var spinner = UIActivityIndicatorView(style: .whiteLarge)

  override func viewDidLoad() {
    super.viewDidLoad()
    hideKeyboardWhenTappedAround()
    navigationItem.title = "Меню"
    navigationController?.navigationBar.isTranslucent = false
    tabBarController?.tabBar.isTranslucent = false
    loadSpinner()
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

  func loadSpinner() {
    spinner.translatesAutoresizingMaskIntoConstraints = false
    spinner.startAnimating()
    view.addSubview(spinner)
    spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    spinner.startAnimating()
  }

  func setupValues() {
    nameLabel.text = viewModel.name
    photoImageView.kf.setImage(with: URL(string: viewModel.image ?? ""), placeholder: #imageLiteral(resourceName: "photo_small"))
    ratingView.rating = Double(viewModel.rating)
    mainInfoLabel.text = viewModel.mainInfo
    summaryLabel.text = viewModel.summary
    skillsLabel.text = viewModel.skills
    referencesTextView.text = ""
    for reference in viewModel.references {
      referencesTextView.text.append("\(reference) \n")
    }
  }
}

extension ProfileViewController: ProfileViewModelDelegate {
  func refresh() {
    spinner.stopAnimating()
    setupValues()
  }

  func failed(with reason: NetworkError) {
    spinner.stopAnimating()
    self.showErrorAlert(reason)
  }
}
