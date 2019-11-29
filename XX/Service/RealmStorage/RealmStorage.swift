//
//  RealmStorage.swift
//  XX
//
//  Created by Seonghun Kim on 2019/11/25.
//  Copyright © 2019 YAPP. All rights reserved.
//

//import Foundation
//import RealmSwift
//import RxRealm
//
//class RealmStorage: NSObject {
//
//}
//
//extension RealmStorage: StorageType {
//    func update(categories: [Category]) {
//        Observable.from(optional: categories)
//            .subscribe(Realm.rx.add())
//            .disposed(by: rx.disposeBag)
//    }
//    
//    func create(expenditure: Expenditure) -> Observable<Expenditure> {
//        Observable.of(expenditure)
//            .subscribe(Realm.rx.add())
//            .disposed(by: rx.disposeBag)
//        
//        return Observable.just(expenditure)
//    }
//    
//    func categoryList() -> Observable<[Category]> {
//        guard let realm = try? Realm() else { return .empty() }
//        
//        let data = realm
//            .objects(Category.self)
//            .sorted(byKeyPath: "id", ascending: true)
//        
//        return Observable
//            .array(from: data)
//    }
//    
//    func history(at month: Int) -> Observable<MonthHistory?> {
//        guard let realm = try? Realm() else { return .empty() }
//        
//        let data = realm
//            .objects(MonthHistory.self)
//            .first
//        
//        return Observable.just(data)
//    }
//    
//    func expenditureList() -> Observable<[Expenditure]> {
//        guard let realm = try? Realm() else { return .empty() }
//        
//        let data = realm
//            .objects(Expenditure.self)
//            .sorted(byKeyPath: "date", ascending: true)
//        
//        return Observable
//            .array(from: data)
//    }
//}
