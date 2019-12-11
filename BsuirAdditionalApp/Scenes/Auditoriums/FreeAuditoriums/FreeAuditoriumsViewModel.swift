//
//  FreeAuditoriumsViewModel.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/8/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import UIKit

protocol FreeAuditoriumsViewModelDelegate: class {
    
    func refreshForm()
    func found(auditoriums: [Auditorium])
    func searchFailed(with reason: NetworkError)
    
}

final class FreeAuditoriumsViewModel {

    weak var delegate: FreeAuditoriumsViewModelDelegate!

    private var buildings: [Building] = []
    
    var buildingsNames: [String] {
        var result: [String] = []
        for building in buildings {
            result.append(String(building.name))
        }
        return result
    }
    
    func floors(by building: String) -> [String] {
        if let number = Int(building), !buildings.filter({ (one) -> Bool in
            return one.name == number
        }).isEmpty {
            return buildings.filter { (one) -> Bool in
                return one.name == number
            }[0].floors.map { (int) -> String in
                return String(int)
            }
        } else {
            return []
        }
    }
    
    func getSavedBuildings() {
        let savedBuildings = DataManager.shared.buildings
        var newBuildings: [Building] = []
        for building in savedBuildings.buildings {
            newBuildings.append(Building(name: building.name, floors: building.floor))
        }
        self.buildings = newBuildings
        self.delegate?.refreshForm()
    }
    
    func fetchBuildings() {
        NetworkingManager.auditoriums.getBuildings { (answer) in
            switch answer {
            case .success(let buildings):
                DataManager.shared.buildings = BuildingsCache(buildings: buildings)
                self.getSavedBuildings()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func findAuditories(building: String?, floor: String?, date: Date?, time: Date?) {
        guard let building = building, let buildimgNumber = Int(building) else {
            self.delegate.searchFailed(with: NetworkError.invalidRequest)
            return
        }
        NetworkingManager.auditoriums.getFreeAuditoriums(building: buildimgNumber, floor: Int(floor ?? ""), date: date?.auditDateFormat, time: time?.auditTimeFormat) { (answer) in
            switch answer {
            case .success(let auditoriums):
                self.delegate.found(auditoriums: auditoriums)
            case .failure(let error):
                self.delegate.searchFailed(with: error)
            }
        }
    }
    
}


