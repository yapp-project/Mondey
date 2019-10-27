//
//  MainViewModel.swift
//  XX
//
//  Created by 박은비 on 19/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import UIKit

class MainViewModel: BaseViewModel {
    func requestSpendDetailMoveAction() -> CocoaAction {
        return Action { _ in 
            
            let viewModel = SpendDetailViewModel(title: "지출디테일", sceneCoordinator: self.sceneCoordinator, storage: self.storage)
            let scene = MainScene.spendDetail(viewModel)
            
            return self
                .sceneCoordinator
                .transition(to: scene,
                            using: .push,
                            animated: true)
                .asObservable().map { _ in }
            
        }
    }
    
    func requestAddSpendMoveMoveAction() -> CocoaAction {
        return Action { _ in
            let viewModel = AddSpendViewModel(title: "추가지출", sceneCoordinator: self.sceneCoordinator, storage: self.storage)
            let scene = MainScene.appSpend(viewModel)
            
            return self
                .sceneCoordinator
                .transition(to: scene,
                            using: .push,
                            animated: true)
                .asObservable().map { _ in }
            
        }
    }
}

