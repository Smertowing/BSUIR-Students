//
//  FilesViewModel.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/8/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import UIKit

protocol FilesViewModelDelegate: class {

}

final class FilesViewModel {
  weak var delegate: FilesViewModelDelegate!

  func refresh(refresher: Bool) {

  }
}
