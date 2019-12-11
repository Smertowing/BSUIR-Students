//
//  FilesProvider.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/1/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import Moya

enum FilesProvider {
}

extension FilesProvider: TargetType {
    
    var baseURL: URL {
        return URL(string: Config.apiUrl)!
    }
    
    var path: String {
        switch self {
        default:
            return "/"
        }
    }
    
    var method: Method {
        switch self {
        default:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return ["Content-Type": "application/json",
            "Authorization": ProfileManager.shared.token]
        }
    }
    
    var validationType: ValidationType {
        return .successCodes
    }

}



