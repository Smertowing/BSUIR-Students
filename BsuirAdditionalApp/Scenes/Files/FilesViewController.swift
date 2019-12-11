//
//  FilesViewController.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/8/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import UIKit

class FilesViewController: UIViewController {
    
    private let viewModel = FilesViewModel()
    
    @IBOutlet weak var newsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        navigationItem.title = "Файлы"
        navigationController?.navigationBar.isTranslucent = false
        tabBarController?.tabBar.isTranslucent = false
        
        setupViewModel()
        configureEventsTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.isUserInteractionEnabled = true
        viewModel.refresh(refresher: false)
    }
    
    private func setupViewModel() {
        viewModel.delegate = self
    }
    
    func configureEventsTable() {
        newsTable.delegate = self
        newsTable.dataSource = self
        newsTable.tableFooterView = UIView()
        newsTable.backgroundView = UIView()
        newsTable.separatorColor = AppColors.textFieldColor.uiColor()
        
        newsTable.refreshControl = UIRefreshControl()
        newsTable.refreshControl?.attributedTitle = NSAttributedString(string: "Загрузка...")
        newsTable.refreshControl?.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
    }
    
    @objc func refresh(sender:AnyObject) {
        viewModel.refresh(refresher: true)
    }
    
}

extension FilesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsTableViewCell
        
        cell.set(.none)
        
        cell.layer.borderColor = AppColors.barsColor.cgColor()
        cell.layer.borderWidth = 4.0
        cell.layer.masksToBounds = true
        
        return cell
    }
    
}

extension FilesViewController: FilesViewModelDelegate {
    
}



