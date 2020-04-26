//
//  NewsSubscriptionsViewModel.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 4/26/20.
//  Copyright © 2020 Kiryl Holubeu. All rights reserved.
//

import UIKit

protocol NewsSubscriptionsViewModelDelegate: class {
  func refreshForm()
  func filterSaved()
  func onSavingFailed(with reason: NetworkError)
}

final class NewsSubscriptionsViewModel {
  weak var delegate: NewsSubscriptionsViewModelDelegate?
}

