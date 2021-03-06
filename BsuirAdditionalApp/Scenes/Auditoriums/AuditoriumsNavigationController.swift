//
//  AuditoriumsNavigationController.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/8/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import UIKit

class AuditoriumsNavigationController: UINavigationController {
  override func viewDidLoad() {
    super.viewDidLoad()
    let storyBoard = UIStoryboard(name: "Auditoriums", bundle: nil)
    let newsViewController = storyBoard.instantiateViewController(withIdentifier: "auditoriumsVC")
    self.pushViewController(newsViewController, animated: false)
    let navigationBarAppearace = UINavigationBar.appearance()
    navigationBarAppearace.tintColor = AppColors.accentColor.uiColor()
    navigationBarAppearace.barTintColor = AppColors.barsColor.uiColor()
    
    NetworkingManager.auditoriums.getBuildings { (answer) in
      switch answer {
      case .success(let buildings):
        DataManager.shared.buildings = BuildingsCache(buildings: buildings)
      case .failure(let error):
        print(error)
      }
    }
  }
}
