//
//  NewsTableViewCell.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/1/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import UIKit
import SDWebImage

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    
    var currentNews: News!

    func set(_ news: News) {
        self.currentNews = news
        
        newsImageView.sd_setImage(with: URL(string: news.urlToImage ?? ""), placeholderImage: #imageLiteral(resourceName: "Logo_1"))
        
        titleLabel.text = news.title
        subtitleLabel.text = news.source.name + " / " + news.source.type
        dateLabel.text = Date(timeIntervalSince1970: news.publishedAt).newsFormat
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
