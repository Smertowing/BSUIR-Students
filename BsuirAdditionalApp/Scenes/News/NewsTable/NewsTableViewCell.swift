//
//  NewsTableViewCell.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/1/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import UIKit
import Kingfisher

class NewsTableViewCell: UITableViewCell {
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var subtitleLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var newsImageView: UIImageView!

  var currentNews: News!

  func set(_ news: News?) {
    guard let news = news else {
      titleLabel.text = ""
      subtitleLabel.text = ""
      dateLabel.text = ""
      newsImageView.image = nil
      return
    }
    self.currentNews = news
    newsImageView.kf.cancelDownloadTask()
    let processor = DownsamplingImageProcessor(size: newsImageView.bounds.size)
    newsImageView.kf.indicatorType = .activity
    newsImageView.kf.setImage(with: URL(string: news.urlToImage ?? ""),
                              placeholder: UIImage(),
                              options: [
                                  .processor(processor),
                                  .scaleFactor(UIScreen.main.scale),
                                  .transition(.fade(1)),
                                  .cacheOriginalImage
                              ])
    titleLabel.text = news.title
    subtitleLabel.text = news.source.name + " / " + news.source.type
    dateLabel.text = news.publishedAt.defaultDate()?.newsFormat
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
