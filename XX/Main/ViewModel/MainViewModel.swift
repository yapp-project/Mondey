//
//  MainViewModel.swift
//  XX
//
//  Created by 박은비 on 19/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import UIKit

class MainViewModel: BaseViewModel {
    var removeMainCollectionViewCell: UIButton?
    
//    func requestSpendDetailMoveAction() -> Action<IndexPath, Void> {
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
    
    /* MainCollectionViewCell */
    func requestMainRemoveModeButtonAction(cellIdx: Int,
                                           button: inout UIButton) -> CocoaAction {
        return Action { action in
            /*
             
             */
            print("cellIdx \(cellIdx)")
            return Observable.just(action)
            
        }
    }
    
    /* MainHeaderReusableView */
    func requestMainHeaderSwipeMoveAction(_ moveCollectionViewPage: @escaping ((MainHeaderMode)-> Void),
                                          mode: MainHeaderMode = .spend) -> CocoaAction {
        return Action { action in
            moveCollectionViewPage(mode) 
            return Observable.just(action)
        }
    }

    
 
}

