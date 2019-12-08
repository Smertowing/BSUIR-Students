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

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        title = "Меню"
        navigationController?.title = nil
        navigationController?.navigationBar.isTranslucent = false
        tabBarController?.tabBar.isTranslucent = false
        setupViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.isUserInteractionEnabled = true

    }

    private func setupViewModel() {
        viewModel.delegate = self
    }
    
}

extension MenuViewController: MenuViewModelDelegate {
    
}

