//
//  GroupViewModel.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/12/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import UIKit

protocol GroupViewModelDelegate: class {
    
    func refresh()
    func failed(with reason: NetworkError)
    
}

final class GroupViewModel {

    weak var delegate: GroupViewModelDelegate!
    
    private var currentGroup: GroupCache?
    
    var count: Int {
        return currentGroup?.members.count ?? 0
    }
    
    func mate(at index: Int) -> GroupMateCache? {
        return currentGroup?.members[index]
    }
    
    func getSavedGroup() {
        if let savedGroup = DataManager.shared.group {
            currentGroup = savedGroup
            self.delegate?.refresh()
        } else {
            fetchGroup()
        }
    }
    
    func fetchGroup() {
        NetworkingManager.iis.getGroup { (answer) in
            switch answer {
            case .success(let group):
                DataManager.shared.group = GroupCache(group: group)
                self.getSavedGroup()
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

