//
//  NewsDetailsViewController.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/2/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import UIKit
import MarkdownKit

class NewsDetailsViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentView: UITextView!
    
    var currentNews: News!
    
    func set(_ news: News) {
        self.currentNews = news
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "№\(currentNews.id)"
        titleLabel.text = currentNews.title
        subtitleLabel.text = currentNews.source.name + " / " + currentNews.source.type
        dateLabel.text = Date(timeIntervalSince1970: currentNews.publishedAt).newsFormat
        
        let markdownParser = MarkdownParser()
        markdownParser.enabledElements = .all
        markdownParser.bold.color = UIColor.white
        markdownParser.italic.color = UIColor.white
        markdownParser.list.color = UIColor.white
        markdownParser.quote.color = UIColor.white
        markdownParser.code.color = UIColor.white
        markdownParser.link.color = AppColors.accentColor.uiColor()
        markdownParser.automaticLink.color = AppColors.accentColor.uiColor()
        markdownParser.header.color = AppColors.accentColor.uiColor()
        contentView.attributedText = markdownParser.parse(currentNews.content)
        let attributedText = NSMutableAttributedString(attributedString: contentView.attributedText!)
        attributedText.enumerateAttribute(.foregroundColor, in: .init(location: 0, length: attributedText.length), options: .longestEffectiveRangeNotRequired) { (attribute, range, _) in
            if (attribute as? UIColor) != nil {
                attributedText.removeAttribute(.foregroundColor, range: range)
                attributedText.addAttribute(.foregroundColor, value: UIColor.white, range: range)
            }
        }
        attributedText.enumerateAttribute(.font, in: .init(location: 0, length: attributedText.length), options: .longestEffectiveRangeNotRequired) { (attribute, range, _) in
            if (attribute as? UIFont) != nil {
                attributedText.removeAttribute(.font, range: range)
                attributedText.addAttribute(.font, value: UIFont.systemFont(ofSize: 22), range: range)
            }
        }
        contentView.attributedText = attributedText
        
    }
    
}
