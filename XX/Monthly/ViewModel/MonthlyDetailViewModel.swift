//
//  MonthlyDetailViewModel.swift
//  XX
//
//  Created by 이재은 on 19/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import Foundation

class MonthlyDetailViewModel: BaseViewModel {

//    func presentPeriodAction() -> CocoaAction {
//        return CocoaAction { [unowned self] action in
//            return Observable.just(action)
//                .withLatestFrom(self.categories)
//                .withLatestFrom(self.budgets, resultSelector: self.mergeCategoryAndBudget)
//                .flatMap(self.moveToPeriodView)
//        }
//    }
    func showNextMonthAction() -> CocoaAction {
        return CocoaAction { [unowned self] action in
            return Observable.just(action)
        }
    }

    func showPreviousMonthAction() -> CocoaAction {
        return CocoaAction { [unowned self] action in
            return Observable.just(action)
        }
    }
}
