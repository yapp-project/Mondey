//
//  IncomeViewModel.swift
//  XX
//
//  Created by Seonghun Kim on 19/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

class IncomeViewModel: BaseViewModel {
    let incomeText = BehaviorRelay(value: "0")

    func presentCategoriesAction() -> CocoaAction {
        return CocoaAction { _ in
            let viewModel = SetCategoriesViewModel(title: "지출항목", viewModel: self)
            let scene = InitializeScene.category(viewModel)
            
            return self.sceneCoordinator.transition(to: scene, using: .push, animated: true).asObservable().map { _ in }
        }
    }
}
