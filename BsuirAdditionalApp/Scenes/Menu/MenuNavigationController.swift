//
//  MenuNavigationController.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/2/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import UIKit

class MenuNavigationController: UINavigationController {
  override func viewDidLoad() {
    super.viewDidLoad()
    let storyBoard = UIStoryboard(name: "Menu", bundle: nil)
    let newsViewController = storyBoard.instantiateViewController(withIdentifier: "menuVC")
    self.pushViewController(newsViewController, animated: false)
    let navigationBarAppearace = UINavigationBar.appearance()
    navigationBarAppearace.tintColor = AppColors.accentColor.uiColor()
    navigationBarAppearace.barTintColor = AppColors.barsColor.uiColor()
  }
}
