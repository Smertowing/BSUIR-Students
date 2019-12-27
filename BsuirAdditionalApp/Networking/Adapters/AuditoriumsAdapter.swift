//
//  AuditoriumsAdapter.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/1/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import Moya

class AuditoriumsAdapter {
  private static let provider = MoyaProvider<AuditoriumsProvider>()

  func getAuditoriums(name: String?, building: Int?, floor: Int?, type: AuditoriumType?, completion: @escaping (Result<([Auditorium]), NetworkError>) -> Void) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    AuditoriumsAdapter.provider.request(.getAuditoriums(name: name, building: building, floor: floor, type: type)) { (result) in
      UIApplication.shared.isNetworkActivityIndicatorVisible = false
      switch result {
      case .success(let response):
        guard let answer = try? response.map([Auditorium].self) else {
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

  func getFreeAuditoriums(building: Int, floor: Int?, date: String?, time: String?, completion: @escaping (Result<([Auditorium]), NetworkError>) -> Void) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    AuditoriumsAdapter.provider.request(.getFreeAuditoriums(building: building, floor: floor, date: date, time: time)) { (result) in
      UIApplication.shared.isNetworkActivityIndicatorVisible = false
      switch result {
      case .success(let response):
        guard let answer = try? response.map([Auditorium].self) else {
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

  func getBuildings(completion: @escaping (Result<([Building]), NetworkError>) -> Void) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    AuditoriumsAdapter.provider.request(.getBuildings) { (result) in
      UIApplication.shared.isNetworkActivityIndicatorVisible = false
      switch result {
      case .success(let response):
        guard let answer = try? response.map([Building].self) else {
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
}
