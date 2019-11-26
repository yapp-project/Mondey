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
    static private var memoryStorage: MemoryStorage? = nil
    
    static func getInstance() -> MemoryStorage {
        
        if self.memoryStorage == nil {
            self.memoryStorage = MemoryStorage()
        }
        
        return self.memoryStorage! 
    }
    
    
    var categories = TempData.categories
    var expenditures = TempData.expenditure
    var monthHistory = TempData.monthHistory
}

extension MemoryStorage: StorageType {
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
