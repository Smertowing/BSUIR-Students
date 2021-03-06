//
//  GroupViewController.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/12/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import UIKit
import SkeletonView

class GroupViewController: UIViewController {
  private let viewModel = GroupViewModel()

  @IBOutlet weak var groupTable: UITableView!

  override func viewDidLoad() {
    super.viewDidLoad()
    hideKeyboardWhenTappedAround()
    navigationItem.title = "Моя группа".localized
    navigationController?.navigationBar.isTranslucent = false
    tabBarController?.tabBar.isTranslucent = false
    setupViewModel()
    configureGroupTable()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.view.isUserInteractionEnabled = true
    viewModel.fetchGroup()
  }

  private func setupViewModel() {
    viewModel.delegate = self
    viewModel.getSavedGroup()
  }

  func configureGroupTable() {
    groupTable.delegate = self
    groupTable.dataSource = self
    groupTable.tableFooterView = UIView()
    groupTable.backgroundView = UIView()
    groupTable.separatorColor = AppColors.textFieldColor.uiColor()
    groupTable.estimatedRowHeight = 150
    groupTable.showAnimatedSkeleton()
  }
}

extension GroupViewController: UITableViewDelegate, UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let number = viewModel.count
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
    let cell = tableView.dequeueReusableCell(withIdentifier: "memberCell", for: indexPath) as! GroupMemberCell

    if let mate = viewModel.mate(at: indexPath.row) {
      cell.set(mate)
    } else {
      cell.set(.none)
    }

    cell.layer.borderColor = AppColors.backgroundColor.cgColor()
    cell.layer.borderWidth = 4.0
    cell.layer.masksToBounds = true

    return cell
  }
}

extension GroupViewController: SkeletonTableViewDataSource {
  func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
     return "memberCell"
  }
}

extension GroupViewController: GroupViewModelDelegate {
  func refresh() {
    groupTable.hideSkeleton()
    self.groupTable.reloadData()
  }

  func failed(with reason: NetworkError) {
    groupTable.hideSkeleton()
    self.showErrorAlert(reason)
  }
}
