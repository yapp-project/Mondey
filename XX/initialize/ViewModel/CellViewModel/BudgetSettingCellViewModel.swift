//
//  BudgetTableViewCellViewModel.swift
//  XX
//
//  Created by Seonghun Kim on 2019/11/02.
//  Copyright © 2019 YAPP. All rights reserved.
//

import Foundation

class BudgetSettingCellViewModel: SignUpSettingCellViewModel {
    let budgetText = BehaviorRelay(value: "")
    
    func budsetString() -> Observable<String> {
        return budgetText
            .map(stringToInt)
            .withLatestFrom(category) {
                ($0 > 99999999) ? $1.budget : $0
            }
            .do(onNext: updateCategory)
            .map(decimal)
    }
    
    func updateCategory(budget: Int) {
        let category = self.category.value
        category.budget = budget
        self.category.accept(category)
    }
}
