//
//  SetCategoriesViewModel.swift
//  XX
//
//  Created by Seonghun Kim on 19/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import Foundation

class SetCategoriesViewModel: BaseViewModel {
    let incomeValue = BehaviorRelay(value: 0)
    let categories = BehaviorRelay(value: SettingModel(initValue: MondeyHelper.mondeyCategory).categories)
    
    func incomeString() -> Observable<String> {
        return incomeValue
            .map(decimal)
    }
    
    func selectItem(_ index: Int) {
        var current = categories.value
        current[index].active = !current[index].active
        
        categories.accept(current)
    }
    
    func presentBudgetAction() -> CocoaAction {
        return CocoaAction { [unowned self] _ in
            let income = self.incomeValue.value
            let categoryList = self.categories.value.filter { $0.active }

            let viewModel = SetBudgetViewModel(title: "예산 설정", viewModel: self)
            viewModel.incomeValue.accept(income)
            viewModel.categories.accept(categoryList)
            let scene = InitializeScene.budget(viewModel)
            
            return self.sceneCoordinator.transition(to: scene, using: .push, animated: true).asObservable().map { _ in }
        }
    }
}
