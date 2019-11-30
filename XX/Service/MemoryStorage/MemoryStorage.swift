//
//  MemoryStorage.swift
//  XX
//
//  Created by Seonghun Kim on 06/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import Foundation

class MemoryStorage {
    
    // 싱글톤 객체
    static let shared = MemoryStorage()
    
    var categories: [Category] = TempData.categories
    var expenditures: [Expenditure] = TempData.expenditure
    var monthHistory: [Int : MonthHistory] = TempData.totalMonthHistory()
}

extension MemoryStorage: StorageType {
    func update(categories: [Category]) {
        self.categories = categories
    }
    
    func create(expenditure: Expenditure) -> Observable<Expenditure> {
        expenditures.append(expenditure)
        
        return Observable.just(expenditure)
    }
    
    func categoryList() -> Observable<[Category]> {
        return Observable.just(categories)
    }
    
    func history(at month: Int) -> Observable<MonthHistory?> {
        return Observable.just(monthHistory[month])
    }
    
    func expenditureList() -> Observable<[Expenditure]> {
        return Observable.just(expenditures)
    }
}
