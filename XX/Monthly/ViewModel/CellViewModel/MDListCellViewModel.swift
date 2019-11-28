//
//  MDListCellViewModel.swift
//  XX
//
//  Created by 이재은 on 24/11/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import Foundation

//protocol MDListCellBindableType {
//    associatedtype ViewModelType
//
//    var viewModel: ViewModelType? { get set }
//
//    func bindViewModel()
//}
//
//extension MDListCellBindableType where Self: UITableViewCell {
//    mutating func bind(viewModel: Self.ViewModelType) {
//        self.viewModel = viewModel
//
//        bindViewModel()
//    }
//}

//class MDListCellViewModel: SignUpSettingCellViewModel {
//    let budgetText = BehaviorRelay(value: "")
//
//    func budsetString() -> Observable<String> {
//        return budgetText
//            .map(stringToInt)
//            .withLatestFrom(category) {
//                ($0 > 99999999) ? $1.budget : $0
//            }
//            .do(onNext: updateCategory)
//            .map(decimal)
//    }
//
//    func updateCategory(budget: Int) {
//        var category = self.category.value
//        category.budget = budget
//        self.category.accept(category)
//    }
//}

class MDListCellViewModel: MonthlyDetailViewModel {
    
}
