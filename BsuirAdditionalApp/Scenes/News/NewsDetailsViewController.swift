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
    @IBOutlet weak var contentLabel: UILabel!
    
    var currentNews: News!
    
    func set(_ news: News) {
        self.currentNews = news
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        contentLabel.attributedText = markdownParser.parse(currentNews.content)
    }
    
}
