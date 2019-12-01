//
//  IISAdapter.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/1/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import Moya

class IISAdapter {
    
    private static let provider = MoyaProvider<IISProvider>()
    
    func auth(login: String, password: String, completion: @escaping (Result<(Token), NetworkError>) -> Void) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        IISAdapter.provider.request(.auth(login: login, password: password)) { (result) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            switch result {
            case .success(let response):
                guard let answer = try? response.map(Token.self) else {
                    return completion(.failure(.invalidResponse))
                }
                return completion(.success(answer))
            case .failure(let error):
                switch error.response?.statusCode {
                case 400:
                    return completion(.failure(.invalidRequest))
                case 500:
                    return completion(.failure(.serverError))
                default:
                    return completion(.failure(.unknownError))
                }
            }
        }
    }
    
    func getUserInfor(by id: Int, completion: @escaping (Result<(User), NetworkError>) -> Void) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        IISAdapter.provider.request(.getUser(id: id)) { (result) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            switch result {
            case .success(let response):
                guard let answer = try? response.map(User.self) else {
                    return completion(.failure(.invalidResponse))
                }
                return completion(.success(answer))
            case .failure(let error):
                switch error.response?.statusCode {
                case 400:
                    return completion(.failure(.invalidRequest))
                case 500:
                    return completion(.failure(.serverError))
                default:
                    return completion(.failure(.unknownError))
                }
            }
        }
    }
    
    func getProfile(completion: @escaping (Result<(User), NetworkError>) -> Void) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        IISAdapter.provider.request(.getProfile) { (result) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            switch result {
            case .success(let response):
                guard let answer = try? response.map(User.self) else {
                    return completion(.failure(.invalidResponse))
                }
                return completion(.success(answer))
            case .failure(let error):
                switch error.response?.statusCode {
                case 400:
                    return completion(.failure(.invalidRequest))
                case 500:
                    return completion(.failure(.serverError))
                default:
                    return completion(.failure(.unknownError))
                }
            }
        }
    }
    
    func getRecordBook(completion: @escaping (Result<(RecordBook), NetworkError>) -> Void) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        IISAdapter.provider.request(.getRecordBook) { (result) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            switch result {
            case .success(let response):
                guard let answer = try? response.map(RecordBook.self) else {
                    return completion(.failure(.invalidResponse))
                }
                return completion(.success(answer))
            case .failure(let error):
                switch error.response?.statusCode {
                case 400:
                    return completion(.failure(.invalidRequest))
                case 500:
                    return completion(.failure(.serverError))
                default:
                    return completion(.failure(.unknownError))
                }
            }
        }
    }
    
    func getDiploma(completion: @escaping (Result<(RecordBook), NetworkError>) -> Void) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        IISAdapter.provider.request(.getDiploma) { (result) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            switch result {
            case .success(let response):
                guard let answer = try? response.map(RecordBook.self) else {
                    return completion(.failure(.invalidResponse))
                }
                return completion(.success(answer))
            case .failure(let error):
                switch error.response?.statusCode {
                case 400:
                    return completion(.failure(.invalidRequest))
                case 500:
                    return completion(.failure(.serverError))
                default:
                    return completion(.failure(.unknownError))
                }
            }
        }
    }
    
    func getGroup(completion: @escaping (Result<(Group), NetworkError>) -> Void) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        IISAdapter.provider.request(.getGroup) { (result) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            switch result {
            case .success(let response):
                guard let answer = try? response.map(Group.self) else {
                    return completion(.failure(.invalidResponse))
                }
                return completion(.success(answer))
            case .failure(let error):
                switch error.response?.statusCode {
                case 400:
                    return completion(.failure(.invalidRequest))
                case 500:
                    return completion(.failure(.serverError))
                default:
                    return completion(.failure(.unknownError))
                }
            }
        }
    }
    
    func getSettings(completion: @escaping (Result<(UserSettings), NetworkError>) -> Void) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        IISAdapter.provider.request(.getSettings) { (result) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            switch result {
            case .success(let response):
                guard let answer = try? response.map(UserSettings.self) else {
                    return completion(.failure(.invalidResponse))
                }
                return completion(.success(answer))
            case .failure(let error):
                switch error.response?.statusCode {
                case 400:
                    return completion(.failure(.invalidRequest))
                case 500:
                    return completion(.failure(.serverError))
                default:
                    return completion(.failure(.unknownError))
                }
            }
        }
    }
    
    func updateSettings(newSettings: UserSettings, completion: @escaping (Result<(UserSettings), NetworkError>) -> Void) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        IISAdapter.provider.request(.updateSettings(settings: newSettings)) { (result) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            switch result {
            case .success:
                return completion(.success(newSettings))
            case .failure(let error):
                switch error.response?.statusCode {
                case 400:
                    return completion(.failure(.invalidRequest))
                case 500:
                    return completion(.failure(.serverError))
                default:
                    return completion(.failure(.unknownError))
                }
            }
        }
    }
    
}


