//
//  AuditoriumsListViewController.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/9/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import UIKit

class AuditoriumsListViewController: UIViewController {
    
    @IBOutlet weak var auditoriumsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        navigationItem.title = "Результат поиска"
        navigationController?.navigationBar.isTranslucent = false
        tabBarController?.tabBar.isTranslucent = false

        configureEventsTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.isUserInteractionEnabled = true
    }
    
    func configureEventsTable() {
        auditoriumsTable.delegate = self
        auditoriumsTable.dataSource = self
        auditoriumsTable.tableFooterView = UIView()
        auditoriumsTable.backgroundView = EmptyBackgroundView.instanceFromNib()
        auditoriumsTable.separatorColor = AppColors.textFieldColor.uiColor()
    }
    
    private var auditoriums: [Auditorium] = []
    
    func configure(with auditoriums: [Auditorium]) {
        self.auditoriums = auditoriums
        self.auditoriumsTable?.reloadData()
    }
}

extension AuditoriumsListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let number = auditoriums.count
        if number == 0 {
            tableView.backgroundView?.isHidden = false
        } else {
            tableView.backgroundView?.isHidden = true
        }
        return number
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "auditoriumCell", for: indexPath) as! AuditoriumListTableViewCell
        cell.set(auditoriums[indexPath.row])
        
        cell.layer.borderColor = AppColors.barsColor.cgColor()
        cell.layer.borderWidth = 4.0
        cell.layer.masksToBounds = true
        return cell
    }
    
}
