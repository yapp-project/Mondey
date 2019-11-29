//
//  StorageType.swift
//  XX
//
//  Created by Seonghun Kim on 06/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import Foundation

protocol StorageType {
    func update(categories: [Category])
    func create(expenditure: Expenditure) -> Observable<Expenditure>
    func categoryList() -> Observable<[Category]>
    func history(at month: Int) -> Observable<MonthHistory?>
    func expenditureList() -> Observable<[Expenditure]>
}
