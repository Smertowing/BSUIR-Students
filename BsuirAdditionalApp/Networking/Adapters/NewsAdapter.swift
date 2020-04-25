//
//  NewsAdapter.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/1/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import Moya

class NewsAdapter {
  private static let provider = MoyaProvider<NewsProvider>()

  func getNews(by id: Int, completion: @escaping (Result<(News), NetworkError>) -> Void) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    NewsAdapter.provider.request(.getNews(id: id)) { (result) in
      UIApplication.shared.isNetworkActivityIndicatorVisible = false
      switch result {
      case .success(let response):
        guard let answer = try? response.map(News.self) else {
          return completion(.failure(.invalidResponse))
        }
        return completion(.success(answer))
      case .failure(let error):
        switch error.response?.statusCode {
        case 400:
          return completion(.failure(.invalidRequest))
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

  func getNewsList(page: Int?, newsAtPage: Int?, title: String?, sort: Sort?,
                   filters: [Filter]?, completion: @escaping (Result<(NewsList), NetworkError>) -> Void) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    NewsAdapter.provider.request(.searchNews(page: page, newsAtPage: newsAtPage, sort: sort, filters: filters)) { (result) in
      UIApplication.shared.isNetworkActivityIndicatorVisible = false
      switch result {
      case .success(let response):
        guard let answer = try? response.map(NewsList.self) else {
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

  func getSources(completion: @escaping (Result<([Source]), NetworkError>) -> Void) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    NewsAdapter.provider.request(.getSources) { (result) in
      UIApplication.shared.isNetworkActivityIndicatorVisible = false
      switch result {
      case .success(let response):
        guard let answer = try? response.map([Source].self) else {
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
  
  func getSubscriptions(completion: @escaping (Result<([String]), NetworkError>) -> Void) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    NewsAdapter.provider.request(.getSubscriptions) { (result) in
      UIApplication.shared.isNetworkActivityIndicatorVisible = false
      switch result {
      case .success(let response):
        guard let answer = try? response.map([String].self) else {
          return completion(.failure(.invalidResponse))
        }
        return completion(.success(answer))
      case .failure(let error):
        switch error.response?.statusCode {
        case 400:
          return completion(.failure(.invalidRequest))
        case 401:
          return completion(.failure(.invalidCredentials))
        case 500:
          return completion(.failure(.serverError))
        default:
          return completion(.failure(.unknownError))
        }
      }
    }
  }
  
  func subscribe(to sources: [Source], completion: @escaping (Result<([Source]), NetworkError>) -> Void) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    NewsAdapter.provider.request(.subscribe(to: sources)) { (result) in
      UIApplication.shared.isNetworkActivityIndicatorVisible = false
      switch result {
      case .success:
        return completion(.success(sources))
      case .failure(let error):
        switch error.response?.statusCode {
        case 400:
          return completion(.failure(.invalidRequest))
        case 401:
          return completion(.failure(.invalidCredentials))
        case 500:
          return completion(.failure(.serverError))
        default:
          return completion(.failure(.unknownError))
        }
      }
    }
  }
}
