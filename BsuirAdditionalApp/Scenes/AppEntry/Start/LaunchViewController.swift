//
//  LaunchViewController.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/1/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {
  @IBOutlet weak var logoImageView: UIImageView!

  override func viewDidLoad() {
    super.viewDidLoad()

    if ProfileManager.shared.isAuthenticated {
      segueToAppllication()
    } else {
      ProfileManager.shared.logout()
      segueToStartScreen()
    }
  }
}
