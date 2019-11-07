//
//  IncomeViewModel.swift
//  XX
//
//  Created by Seonghun Kim on 19/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

class IncomeSettingViewModel: BaseViewModel {
    let incomeText = BehaviorRelay(value: "")
    
    private let incomeValue = BehaviorRelay(value: 0)
    
    func incomeString() -> Observable<String> {
        return incomeText
            .map(stringToInt)
            .withLatestFrom(incomeValue) {
                ($0 > 99999999) ? $1 : $0
            }
            .do(onNext: incomeValue.accept)
            .map(decimal)
    }

    func presentCategoriesAction() -> CocoaAction {
        return CocoaAction { [unowned self] _ in
            let income = self.incomeValue.value
            UserDefaultManager.budget = income
            
            let viewModel = CategoriesSetting(title: "지출항목", viewModel: self)
            viewModel.incomeValue.accept(income * 10000)
            let scene = SignUpSettingScene.category(viewModel)
            
            return self.sceneCoordinator.transition(to: scene, using: .push, animated: true).asObservable().map { _ in }
        }
    }
}
