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
        case 500:
          return completion(.failure(.serverError))
        default:
          return completion(.failure(.unknownError))
        }
      }
    }
  }

  func getNewsList(page: Int?, newsAtPage: Int?, title: String?, q: String?, url: String?, source: Int?,
                   sources: [Int]?, loadedAfter: TimeInterval?, loadedBefore: TimeInterval?, publishedAfter: TimeInterval?, publishedBefore: TimeInterval?, completion: @escaping (Result<(NewsList), NetworkError>) -> Void) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    NewsAdapter.provider.request(.getNewsList(page: page, newsAtPage: newsAtPage, title: title, q: q, url: url, source: source,
                                              sources: sources, loadedAfter: loadedAfter, loadedBefore: loadedBefore, publishedAfter: publishedAfter, publishedBefore: publishedBefore)) { (result) in
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

  func getSources(by type: NewsSourceType, completion: @escaping (Result<([Source]), NetworkError>) -> Void) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    NewsAdapter.provider.request(.getSources(type: type)) { (result) in
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
}
