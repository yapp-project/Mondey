//
//  SetBudgetViewModel.swift
//  XX
//
//  Created by Seonghun Kim on 19/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import Foundation

class SetBudgetViewModel: BaseViewModel {
    func presentPeriodAction() -> CocoaAction {
        return CocoaAction { _ in
            let viewModel = SetPeriodViewModel(title: "예산 주기", viewModel: self)
            let scene = InitializeScene.period(viewModel)
            
            return self.sceneCoordinator.transition(to: scene, using: .push, animated: true).asObservable().map { _ in }
        }
    }
}
