//
//  SettingsViewModel.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/12/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import UIKit

protocol SettingsViewModelDelegate: class {
    
    func refresh()
    func failed(with reason: NetworkError)
    
}

final class SettingsViewModel {

    weak var delegate: SettingsViewModelDelegate!
    
    private var currentSettings: SettingsCache?
    
    var isProfile: Bool {
        return currentSettings?.isPublicProfile ?? false
    }
    
    var isRating: Bool {
        return currentSettings?.isShowRating ?? false
    }
    
    var isWork: Bool {
        return currentSettings?.isSearchJob ?? false
    }
    
    func getSavedSettings() {
        if let savedSettings = DataManager.shared.settings {
            currentSettings = savedSettings
            self.delegate?.refresh()
        } else {
            fetchSettings()
        }
    }
    
    func fetchSettings() {
        NetworkingManager.iis.getSettings { (answer) in
            switch answer {
            case .success(let settings):
                DataManager.shared.settings = SettingsCache(settings: settings)
                self.getSavedSettings()
            case .failure(let error):
                print(error)
            }
        }
    }
}

