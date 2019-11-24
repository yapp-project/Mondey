//
//  PeriodTableViewCellViewModel.swift
//  XX
//
//  Created by Seonghun Kim on 2019/11/02.
//  Copyright © 2019 YAPP. All rights reserved.
//

import Foundation

class PeriodSettingCellViewModel: SignUpSettingCellViewModel {
    let periodType = BehaviorRelay<Category.Period>(value: .none)
    
    func dayOptionAction() -> CocoaAction {
        return Action { [unowned self] action in
            return Observable.just(action)
                .map { Category.Period.day }
                .map(self.updatePeriodType)
        }
    }
    
    func weekOptionAction() -> CocoaAction {
        return Action { [unowned self] action in
            return Observable.just(action)
                .map { Category.Period.week }
                .map(self.updatePeriodType)
        }
    }
    
    func monthOptionAction() -> CocoaAction {
        return Action { [unowned self] action in
            return Observable.just(action)
                .map { Category.Period.month }
                .map(self.updatePeriodType)
        }
    }
    
    private func updatePeriodType(type: Category.Period) {
        periodType.accept(type)
    }
}
