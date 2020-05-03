//
//  NewsSubscriptionsViewController.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 4/26/20.
//  Copyright © 2020 Kiryl Holubeu. All rights reserved.
//

import UIKit

class NewsSubscriptionsViewController: UIViewController {
  private let viewModel = NewsSubscriptionsViewModel()
  
  @IBOutlet weak var subscriptionsTable: UITableView!

  override func viewDidLoad() {
    super.viewDidLoad()
    hideKeyboardWhenTappedAround()
    navigationItem.title = "Подписки".localized
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
    viewModel.getSavedSubscriptions()
  }

  func configureEventsTable() {
    subscriptionsTable.delegate = self
    subscriptionsTable.dataSource = self
    subscriptionsTable.tableFooterView = UIView()
    subscriptionsTable.backgroundView = EmptyBackgroundView.instanceFromNib()
    subscriptionsTable.separatorColor = AppColors.textFieldColor.uiColor()
    
    
    subscriptionsTable.refreshControl = UIRefreshControl()
    subscriptionsTable.refreshControl?.attributedTitle = NSAttributedString(string: "Загрузка...".localized)
    subscriptionsTable.refreshControl?.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
  }
  
  @objc func refresh(sender: AnyObject) {
    viewModel.refresh(refresher: true)
  }
}

extension NewsSubscriptionsViewController: UITableViewDelegate, UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return viewModel.categoriesCount
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return viewModel.name(of: section)
  }
  
  func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
    (view as! UITableViewHeaderFooterView).contentView.backgroundColor = AppColors.backgroundColor.uiColor()
    (view as! UITableViewHeaderFooterView).textLabel?.textColor = AppColors.accentColor.uiColor()
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 24
  }
  
  func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
    (view as! UITableViewHeaderFooterView).contentView.backgroundColor = AppColors.backgroundColor.uiColor()
    (view as! UITableViewHeaderFooterView).textLabel?.textColor = AppColors.accentColor.uiColor()
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.sourcesCount(in: section)
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "subscribtionCell", for: indexPath) as? NewsSubscriptionsTableViewCell else {
      return UITableViewCell()
    }
    
    cell.set(viewModel.source(at: indexPath)) { subscribe in
      self.viewModel.updateSubcription(indexPath: indexPath, subscribe: subscribe)
    }
    
    cell.layer.borderColor = AppColors.backgroundColor.cgColor()
    cell.layer.masksToBounds = true
    return cell
  }
}

extension NewsSubscriptionsViewController: NewsSubscriptionsViewModelDelegate {
  func onFetchCompleted() {
    subscriptionsTable.refreshControl?.endRefreshing()
    subscriptionsTable.reloadData()
  }
  
  func onFetchFailed(with reason: NetworkError) {
    subscriptionsTable.refreshControl?.endRefreshing()
    subscriptionsTable.reloadData()
  }
}

