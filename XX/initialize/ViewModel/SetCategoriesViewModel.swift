//
//  SetCategoriesViewModel.swift
//  XX
//
//  Created by Seonghun Kim on 19/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import Foundation

class SetCategoriesViewModel: BaseViewModel {
    func presentBudgetAction() -> CocoaAction {
        return CocoaAction { _ in
            let viewModel = SetBudgetViewModel(title: "예산목록", viewModel: self)
            let scene = InitializeScene.budget(viewModel)
            
            return self.sceneCoordinator.transition(to: scene, using: .push, animated: true).asObservable().map { _ in }
        }
    }
}
