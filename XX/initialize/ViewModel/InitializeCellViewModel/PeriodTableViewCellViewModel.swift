//
//  PeriodTableViewCellViewModel.swift
//  XX
//
//  Created by Seonghun Kim on 2019/11/02.
//  Copyright © 2019 YAPP. All rights reserved.
//

import Foundation

class PeriodTableViewCellViewModel: InitializeCellViewModel {
    let periodType = BehaviorRelay<Category.Period?>(value: nil)
    
    override init() {
        super.init()
        
        category.map { $0.period }
            .bind(to: periodType)
            .disposed(by: rx.disposeBag)
    }
    
    func updatePeriod(_ period: Category.Period) {
        guard let current = periodType.value else {
            periodType.accept(period)
            return
        }
        
        let value = (current == period) ? Category.Period.none : period
        periodType.accept(value)
    }
}
