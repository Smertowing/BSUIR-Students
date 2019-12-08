//
//  RatingsNavigationController.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/8/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import UIKit

class RatingsNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let storyBoard = UIStoryboard(name: "Ratings", bundle: nil)
        let newsViewController = storyBoard.instantiateViewController(withIdentifier: "ratingsVC")
        self.pushViewController(newsViewController, animated: false)
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.tintColor = AppColors.accentColor.uiColor()
        navigationBarAppearace.barTintColor = AppColors.barsColor.uiColor()
    }

}

