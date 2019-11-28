//
//  RealmStorage.swift
//  XX
//
//  Created by Seonghun Kim on 2019/11/25.
//  Copyright © 2019 YAPP. All rights reserved.
//

import Foundation

class RealmStorage {
    
}

extension RealmStorage: StorageType {
    func create(expenditure: Expenditure) -> Observable<Expenditure> {
//        expenditures.append(expenditure)
        
        return Observable.just(expenditure)
    }
    
    func categoryList() -> Observable<[Category]> {
        return Observable.just([])
    }
    
    func history(at month: Int) -> Observable<MonthHistory?> {
        return Observable.just(nil)
    }
    
    func expenditureList() -> Observable<[Expenditure]> {
        return Observable.just([])
    }
}
