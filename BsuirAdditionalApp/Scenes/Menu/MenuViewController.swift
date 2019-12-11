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
        navigationItem.title = "Меню"
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
        photoImageView.sd_setImage(with: URL(string: viewModel.image ?? ""), placeholderImage: #imageLiteral(resourceName: "photo_small"))
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

