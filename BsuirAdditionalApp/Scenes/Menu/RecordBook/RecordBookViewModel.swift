//
//  RecordBookViewModel.swift
//  BsuirAdditionalApp
//
//  Created by Kiryl Holubeu on 12/12/19.
//  Copyright © 2019 Kiryl Holubeu. All rights reserved.
//

import UIKit

protocol RecordBookViewModelDelegate: class {
    
    func refresh()
    func failed(with reason: NetworkError)
    
}

final class RecordBookViewModel {

    weak var delegate: RecordBookViewModelDelegate!
    
    private var currentRecordBook: RecordBookCache?
    
    var numberString: String {
        return currentRecordBook?.number ?? "–"
    }
    
    var avarageMarkString: String {
        if let currentRecordBook = currentRecordBook {
            return String(format: "%.2f", currentRecordBook.averageMark)
        } else {
            return "–"
        }
    }
    
    
    var semesters: [SemesterView] {
        var result: [SemesterView] = []
        for semeseter in currentRecordBook?.semesters ?? [] {
            let semView: SemesterView = SemesterView.instanceFromNib()
            semView.set(semeseter)
            result.append(semView)
        }
        return result
    }
    
    
    func getSavedRecordBook() {
        if let savedRecordBook = DataManager.shared.recordBook {
            currentRecordBook = savedRecordBook
            self.delegate?.refresh()
        } else {
            fetchRecordBook()
        }
    }
    
    func fetchRecordBook() {
        NetworkingManager.iis.getRecordBook { (answer) in
            switch answer {
            case .success(let book):
                DataManager.shared.recordBook = RecordBookCache(book: book)
                self.getSavedRecordBook()
            case .failure(let error):
                print(error)
            }
        }
    }
}

