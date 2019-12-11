//
//  SettingsViewController.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/12/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    private let viewModel = SettingsViewModel()

    @IBOutlet weak var ratingSwitch: UISwitch!
    @IBOutlet weak var profileSwitch: UISwitch!
    @IBOutlet weak var workSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        navigationItem.title = "Настройки"
        navigationController?.navigationBar.isTranslucent = false
        tabBarController?.tabBar.isTranslucent = false
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
    
    func setupValues() {
        ratingSwitch.isOn = viewModel.isRating
        profileSwitch.isOn = viewModel.isProfile
        workSwitch.isOn = viewModel.isWork
    }
    
}

extension SettingsViewController: SettingsViewModelDelegate {
    
    func refresh() {
        setupValues()
    }
    
    func failed(with reason: NetworkError) {
        self.showErrorAlert(reason)
    }

}


