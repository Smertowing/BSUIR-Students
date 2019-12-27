//
//  RecordBookViewController.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/12/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import UIKit

class RecordBookViewController: UIViewController {
  private let viewModel = RecordBookViewModel()

  @IBOutlet weak var numberLabel: UILabel!
  @IBOutlet weak var averageMarkLabel: UILabel!
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var pageControl: UIPageControl!

  var spinner = UIActivityIndicatorView(style: .whiteLarge)

  override func viewDidLoad() {
    super.viewDidLoad()
    hideKeyboardWhenTappedAround()
    navigationItem.title = "Моя зачетка"
    navigationController?.navigationBar.isTranslucent = false
    tabBarController?.tabBar.isTranslucent = false
    loadSpinner()
    setupViewModel()
    scrollView.delegate = self
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.view.isUserInteractionEnabled = true
    viewModel.fetchRecordBook()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    viewModel.getSavedRecordBook()
  }

  private func setupViewModel() {
    viewModel.delegate = self
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
    numberLabel.text = viewModel.numberString
    averageMarkLabel.text = viewModel.avarageMarkString

    let views = viewModel.semesters
    scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
    scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(views.count), height: view.frame.height)
    scrollView.isPagingEnabled = true

    for i in 0 ..< views.count {
      views[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
      scrollView.addSubview(views[i])
    }

    pageControl.numberOfPages = views.count
    pageControl.currentPage = 0
    view.bringSubviewToFront(pageControl)
  }

  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    setupValues()
  }
}

extension RecordBookViewController: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
    pageControl.currentPage = Int(pageIndex)

    if scrollView.contentOffset.y > 0 || scrollView.contentOffset.y < 0 {
      scrollView.contentOffset.y = 0
    }
  }
}

extension RecordBookViewController: RecordBookViewModelDelegate {
  func refresh() {
    spinner.stopAnimating()
    setupValues()
  }

  func failed(with reason: NetworkError) {
    spinner.stopAnimating()
    self.showErrorAlert(reason) {
      self.setupValues()
    }
  }
}
