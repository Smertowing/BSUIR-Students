//
//  NewsViewModel.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/1/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import UIKit

protocol NewsViewModelDelegate: class {
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?)
    func onFetchFailed(with reason: NetworkError)
}

final class NewsViewModel {
    
    weak var delegate: NewsViewModelDelegate?
    
    private var newsList: NewsList? {
        willSet {
            guard let value = newValue else {
                return
            }
            total = value.count
            news.append(contentsOf: value.news)
            
            if value.page > 1 {
                let indexPathsToReload = self.calculateIndexPathsToReload(from: value.news)
                self.delegate?.onFetchCompleted(with: indexPathsToReload)
            } else {
                self.delegate?.onFetchCompleted(with: .none)
            }
        }
    }
    private var news: [News] = []
    private var currentPage = 1
    private var perPage = 10
    private var total = 0
    private var isFetchInProgress = false
    
    var totalCount: Int {
        return total
    }
    
    var currentCount: Int {
        return news.count
    }
    
    func news(at index: Int) -> News {
        return news[index]
    }
    
    func refresh(refresher: Bool) {
        guard !isFetchInProgress else {
            return
        }
        
        news = []
        currentPage = 1
        total = 0
        
        fetch()
    }
    
    func fetch() {
        fetchNews(page: currentPage, perPage: perPage)
    }
    
    private func fetchNews(page: Int, perPage: Int) {
        
        guard !isFetchInProgress else {
            return
        }
        
        isFetchInProgress = true
        
        NetworkingManager.news.getNewsList(page: page, newsAtPage: perPage, title: nil, q: nil, url: nil, source: nil, sources: nil, loadedAfter: nil, loadedBefore: nil, publishedAfter: nil, publishedBefore: nil) { (answer) in
            switch answer {
            case .success(let newsList):
                DispatchQueue.main.async {
                    self.currentPage += 1
                    self.isFetchInProgress = false
                    self.newsList = newsList
                }
            case .failure(let error):
                self.isFetchInProgress = false
                self.delegate?.onFetchFailed(with: error)
            }
        }
    }
    
    private func calculateIndexPathsToReload(from newNews: [News]) -> [IndexPath] {
        let startIndex = news.count - newNews.count
        let endIndex = startIndex + newNews.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
    
}

