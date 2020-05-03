//
//  NotificationsAdapter.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 5/3/20.
//  Copyright © 2020 Kiryl Holubeu. All rights reserved.
//

import Moya

class NotificationsAdapter {
  private static let provider = MoyaProvider<NotificationsProvider>()
  
  func subscribe(with token: String, completion: @escaping (Result<(String), NetworkError>) -> Void) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    NotificationsAdapter.provider.request(.subscribe(token: token)) { (result) in
      UIApplication.shared.isNetworkActivityIndicatorVisible = false
      switch result {
      case .success:
        return completion(.success(token))
      case .failure(let error):
        switch error.response?.statusCode {
        case 400:
          return completion(.failure(.invalidRequest))
        case 401:
          return completion(.failure(.invalidCredentials))
        case 404:
          return completion(.failure(.notFound))
        case 500:
          return completion(.failure(.serverError))
        default:
          return completion(.failure(.unknownError))
        }
      }
    }
  }
  
  func unsubscribe(with token: String, completion: @escaping (Result<(String), NetworkError>) -> Void) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    NotificationsAdapter.provider.request(.unsubscribe(token: token)) { (result) in
      UIApplication.shared.isNetworkActivityIndicatorVisible = false
      switch result {
      case .success:
        return completion(.success(token))
      case .failure(let error):
        switch error.response?.statusCode {
        case 400:
          return completion(.failure(.invalidRequest))
        case 401:
          return completion(.failure(.invalidCredentials))
        case 404:
          return completion(.failure(.notFound))
        case 500:
          return completion(.failure(.serverError))
        default:
          return completion(.failure(.unknownError))
        }
      }
    }
  }
}
