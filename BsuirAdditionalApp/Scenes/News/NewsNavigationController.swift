//
//  NewsNavigationController.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/1/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import UIKit

class NewsNavigationController: UINavigationController {
  override func viewDidLoad() {
    super.viewDidLoad()
    let storyBoard = UIStoryboard(name: "News", bundle: nil)
    let newsViewController = storyBoard.instantiateViewController(withIdentifier: "newsVC")
    self.pushViewController(newsViewController, animated: false)
    let navigationBarAppearace = UINavigationBar.appearance()
    navigationBarAppearace.tintColor = AppColors.accentColor.uiColor()
    navigationBarAppearace.barTintColor = AppColors.barsColor.uiColor()
  }
}
