//
//  FinishInitViewModel.swift
//  XX
//
//  Created by Seonghun Kim on 19/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import Foundation

class SignUpSettingCompletionViewModel: BaseViewModel {
    let incomeValue = BehaviorRelay(value: 0)
    let categories = BehaviorRelay<[Category]>(value: [])
    
    func presentMainAction() -> CocoaAction {
        let income = self.incomeValue.value
        let categoryList = self.categories.value
        
        return CocoaAction { _ in
            guard let dataStorage = self.storage as? MemoryStorage else { return Observable.just(()) }
            UserDefaultManager.budget = income
            dataStorage.categories = categoryList
            let viewModel = MainViewModel(title: "메인", viewModel: self)
            let scene = MainScene.main(viewModel)

            return self.sceneCoordinator.transition(to: scene, using: .root, animated: true).asObservable().map { _ in }
        }
    }
}
