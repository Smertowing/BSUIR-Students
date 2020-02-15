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
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var subtitleLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var contentView: UITextView!

  var currentNews: News!
  var spinner = UIActivityIndicatorView(style: .whiteLarge)

  func set(_ news: News) {
    self.currentNews = news
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "№\(currentNews.id)"
    titleLabel.text = currentNews.title
    subtitleLabel.text = currentNews.source.name + " / " + currentNews.source.type.rawValue
    dateLabel.text = Date(timeIntervalSince1970: currentNews.publishedAt).newsFormat

    loadSpinner()
    loadContent()
  }

  func loadSpinner() {
    spinner.translatesAutoresizingMaskIntoConstraints = false
    spinner.startAnimating()
    view.addSubview(spinner)
    spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    spinner.startAnimating()
  }

  func loadContent() {
    DispatchQueue.global(qos: .background).async {
      let down = Down(markdownString: self.currentNews.content)

      guard let markdown = try? down.toAttributedString() else {
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
