//
//  NewsViewController.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/1/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import UIKit
import SkeletonView

class NewsViewController: UIViewController {
  private let viewModel = NewsViewModel()

  @IBOutlet weak var newsTable: UITableView!
  @IBOutlet weak var newsTabCollection: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    hideKeyboardWhenTappedAround()
    navigationItem.title = "Новости".localized
    navigationController?.navigationBar.isTranslucent = false
    tabBarController?.tabBar.isTranslucent = false
    self.navigationItem.setRightBarButton(UIBarButtonItem(image: #imageLiteral(resourceName: "subscriptions"), style: .plain, target: self, action: #selector(self.subscriptionsButtonClicked)), animated: false)
    //self.navigationItem.setRightBarButton(UIBarButtonItem(image: #imageLiteral(resourceName: "filter_off"), style: .plain, target: self, action: #selector(self.filterButtonClicked)), animated: false)
    setupViewModel()
    configureEventsTable()
    configureTabCollection()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.view.isUserInteractionEnabled = true
    viewModel.getSavedSubscriptions()
    viewModel.refresh(refresher: false)
  }

  private func setupViewModel() {
    viewModel.delegate = self
  }

  func configureEventsTable() {
    newsTable.delegate = self
    newsTable.dataSource = self
    newsTable.prefetchDataSource = self
    newsTable.tableFooterView = UIView()
    newsTable.backgroundView = EmptyBackgroundView.instanceFromNib()
    newsTable.separatorColor = AppColors.textFieldColor.uiColor()
    newsTable.estimatedRowHeight = 300
    newsTable.showAnimatedSkeleton()
    
    newsTable.refreshControl = UIRefreshControl()
    newsTable.refreshControl?.attributedTitle = NSAttributedString(string: "Загрузка...".localized)
    newsTable.refreshControl?.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
  }
  
  func configureTabCollection() {
    newsTabCollection.delegate = self
    newsTabCollection.dataSource = self
  }

  @objc func refresh(sender: AnyObject) {
    viewModel.refresh(refresher: true)
  }

  @objc func filterButtonClicked() {
    let storyBoard = UIStoryboard(name: "News", bundle: nil)
    let filterNewsViewController = storyBoard.instantiateViewController(withIdentifier: "filterNewsVC")
    self.show(filterNewsViewController, sender: self)
  }
  
  @objc func subscriptionsButtonClicked() {
    let storyBoard = UIStoryboard(name: "News", bundle: nil)
    let filterNewsViewController = storyBoard.instantiateViewController(withIdentifier: "subscriptionsTableVC")
    self.show(filterNewsViewController, sender: self)
  }
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

    let number = viewModel.fetching ? (0) : (viewModel.totalCount)
    if number == 0 {
      tableView.backgroundView?.isHidden = false
    } else {
      tableView.backgroundView?.isHidden = true
    }
    return number
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    if !isLoadingCell(for: indexPath) {
      let storyBoard = UIStoryboard(name: "News", bundle: nil)
      let newsDetailsViewController = storyBoard.instantiateViewController(withIdentifier: "newsDetailsVC") as! NewsDetailsViewController
      newsDetailsViewController.set(viewModel.news(at: indexPath.row))
      self.show(newsDetailsViewController, sender: self)
    }
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsTableViewCell

    if isLoadingCell(for: indexPath) {
      cell.set(.none)
    } else {
      cell.set(viewModel.news(at: indexPath.row))
    }

    cell.layer.borderColor = AppColors.backgroundColor.cgColor()
    cell.layer.borderWidth = 4.0
    cell.layer.masksToBounds = true

    return cell
  }
}

extension NewsViewController: SkeletonTableViewDataSource {
  func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
    return "newsCell"
  }
}

extension NewsViewController: UITableViewDataSourcePrefetching {
  func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
    if indexPaths.contains(where: isLoadingCell) {
      viewModel.fetch()
    }
  }
}

extension NewsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.numberOfTabs + 2
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if let cell = collectionView.cellForItem(at: indexPath) as? NewsCollectionViewCell {
      cell.accentView.backgroundColor = AppColors.accentColor.uiColor()
    }
    viewModel.updateTab(to: indexPath.row)
  }
  
  func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    if let cell = collectionView.cellForItem(at: indexPath) as? NewsCollectionViewCell {
      cell.accentView.backgroundColor = UIColor.clear
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tabCell", for: indexPath) as! NewsCollectionViewCell
    if indexPath.row == 1 {
      cell.tabNameLabel.text = "Подписки".localized
    } else if indexPath.row == 0 {
      cell.tabNameLabel.text = "Все новости".localized
    } else {
      cell.tabNameLabel.text = viewModel.tab(at: indexPath.row - 2).name
    }
    
    if cell.isSelected {
      cell.accentView.backgroundColor = AppColors.accentColor.uiColor()
    } else {
      cell.accentView.backgroundColor = UIColor.clear
    }
    
//    cell.layer.borderColor = UIColor.clear.cgColor
//    cell.layer.borderWidth = 4.0
    cell.layer.masksToBounds = true
    return cell
  }
}

private extension NewsViewController {
  func isLoadingCell(for indexPath: IndexPath) -> Bool {
    return indexPath.row >= viewModel.currentCount
  }

  func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
    let indexPathsForVisibleRows = newsTable.indexPathsForVisibleRows ?? []
    let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
    return Array(indexPathsIntersection)
  }
}

extension NewsViewController: NewsViewModelDelegate {
  func reloadTabs() {
    newsTabCollection.reloadData()
    newsTabCollection.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .left)
  }
  
  func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?) {
    newsTable.hideSkeleton()
    newsTable.refreshControl?.endRefreshing()
    guard let newIndexPathsToReload = newIndexPathsToReload else {
      newsTable.reloadData()
      return
    }

    let indexPathsToReload = visibleIndexPathsToReload(intersecting: newIndexPathsToReload)
    newsTable.reloadRows(at: indexPathsToReload, with: .none)
  }

  func onFetchFailed(with reason: NetworkError) {
    newsTable.hideSkeleton()
    newsTable.refreshControl?.endRefreshing()
    newsTable.reloadData()
  }
}
