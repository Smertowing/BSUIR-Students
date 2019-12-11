//
//  AllAuditoriumsViewModel.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/11/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import UIKit

protocol AllAuditoriumsViewModelDelegate: class {
    
    func refreshForm()
    func found(auditoriums: [Auditorium])
    func searchFailed(with reason: NetworkError)
    
}

final class AllAuditoriumsViewModel {

    weak var delegate: AllAuditoriumsViewModelDelegate!

    private var buildings: [Building] = []
    
    var buildingsNames: [String] {
        var result: [String] = []
        for building in buildings {
            result.append(String(building.name))
        }
        return result
    }
    
    var types: [String] {
        var result: [String] = []
        for type in AuditoriumType.allValues {
            switch type {
            case .lecture:
                result.append("ЛК")
            case .lab:
                result.append("ЛБ")
            case .practice:
                result.append("ПЗ")
            @unknown default:
                break
            }
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
    
    func findAuditories(name: String?, building: String?, floor: String?, type: String?) {
        var recognisedType: AuditoriumType? = nil
        if let type = type {
            switch type {
            case "ЛК":
                recognisedType = .lecture
            case "ЛБ":
                recognisedType = .lab
            case "ПЗ":
                recognisedType = .practice
            default:
                break
            }
        }
        NetworkingManager.auditoriums.getAuditoriums(name: name, building: Int(building ?? ""), floor: Int(floor ?? ""), type: recognisedType) { (answer) in
            switch answer {
            case .success(let auditoriums):
                self.delegate.found(auditoriums: auditoriums)
            case .failure(let error):
                self.delegate.searchFailed(with: error)
            }
        }
    
    }
    
}



