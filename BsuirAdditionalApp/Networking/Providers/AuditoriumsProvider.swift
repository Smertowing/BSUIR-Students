//
//  AuditoriumsProvider.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/1/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import Moya

enum AuditoriumsProvider {
    case getAuditoriums(name: String?, building: Int?, floor: Int?, type: AuditoriumType?)
    case getFreeAuditoriums(building: Int, floor: Int?, date: String?, time: String?)
    case getBuildings
}

extension AuditoriumsProvider: TargetType {
    
    var baseURL: URL {
        return URL(string: Config.apiUrl)!
    }
    
    var path: String {
        switch self {
        case .getAuditoriums:
            return "/auditoriums"
        case .getFreeAuditoriums:
            return "/auditoriums/free"
        case .getBuildings:
            return "/buildings"
        }
    }
    
    var method: Method {
        switch self {
        case .getAuditoriums:
            return .get
        case .getFreeAuditoriums:
            return .get
        case .getBuildings:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getAuditoriums(let name, let building, let floor, let type):
            var params: [String:Any] = [:]
            if let name = name {
                params["name"] = name
            }
            if let building = building {
                params["building"] = building
            }
            if let floor = floor {
                params["floor"] = floor
            }
            if let type = type {
                params["type"] = type.rawValue
            }
            return .requestParameters(
                parameters: params,
                encoding: URLEncoding.default
            )
        case .getFreeAuditoriums(let building, let floor, let date, let time):
            var params: [String:Any] = ["building":building]
     
            if let floor = floor {
                params["floor"] = floor
            }
            if let date = date {
                params["date"] = date
            }
            if let time = time {
                params["time"] = time
            }
            return .requestParameters(
                parameters: params,
                encoding: URLEncoding.default
            )
        case .getBuildings:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getAuditoriums:
            return ["Content-Type": "application/json"]
        case .getFreeAuditoriums:
            return ["Content-Type": "application/json"]
        case .getBuildings:
            return ["Content-Type": "application/json"]
        }
    }
    
    var validationType: ValidationType {
        return .successCodes
    }

}
