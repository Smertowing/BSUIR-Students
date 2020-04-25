//
//  NewsDetailsViewController.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/2/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import UIKit
import Down

class NewsDetailsViewController: UIViewController {
  private let viewModel = NewsDetailsViewModel()
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var subtitleLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var contentView: UITextView!

  var spinner = UIActivityIndicatorView(style: .whiteLarge)

  func set(_ news: News) {
    self.viewModel.setCurrentNews(with: news)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "№\(viewModel.id)"
    setupViewModel()
    titleLabel.text = viewModel.title
    subtitleLabel.text = viewModel.source.name + " / " + viewModel.source.type
    dateLabel.text = viewModel.date.defaultDate()?.newsFormat

    loadSpinner()
    viewModel.loadContent()
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
  
  @IBAction func openSource(_ sender: Any) {
    guard let url = viewModel.url else {
      return
    }
    
    if #available(iOS 10.0, *) {
      UIApplication.shared.open(url, options: [:], completionHandler: nil)
    } else {
      UIApplication.shared.openURL(url)
    }
  }
  
  func loadContent() {
    DispatchQueue.global(qos: .background).async {
      guard let markdown = try? Down(markdownString: self.viewModel.content ?? "").toAttributedString() else {
        DispatchQueue.main.async {
          self.spinner.stopAnimating()
        }
        return
      }

      DispatchQueue.main.async {
        self.contentView.attributedText = markdown
        self.spinner.stopAnimating()
      }

      let attributedText = NSMutableAttributedString(attributedString: markdown)
      attributedText.enumerateAttribute(.foregroundColor, in: .init(location: 0, length: attributedText.length), options: .longestEffectiveRangeNotRequired) { (attribute, range, _) in
        if (attribute as? UIColor) != nil {
          attributedText.removeAttribute(.foregroundColor, range: range)
          attributedText.addAttribute(.foregroundColor, value: AppColors.textColor.uiColor(), range: range)
        }
      }
      attributedText.enumerateAttribute(.font, in: .init(location: 0, length: attributedText.length), options: .longestEffectiveRangeNotRequired) { (attribute, range, _) in
        if (attribute as? UIFont) != nil {
          attributedText.removeAttribute(.font, range: range)
          attributedText.addAttribute(.font, value: UIFont.systemFont(ofSize: 22), range: range)
        }
      }

      DispatchQueue.main.async {
        self.contentView.attributedText = attributedText.attributedStringWithResizedImages(with: self.view.bounds.width*0.9)
      }
    }
  }
}

extension NewsDetailsViewController: NewsDetailsViewModelDelegate {
  func reloadContent() {
    loadContent()
  }
}
