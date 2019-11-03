//
//  FinishInitViewModel.swift
//  XX
//
//  Created by Seonghun Kim on 19/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import Foundation

class FinishInitViewModel: BaseViewModel {
    func presentMainAction() -> CocoaAction {
        return CocoaAction { _ in
//            let storage = MemoryStorage()
            let viewModel = MainViewModel(title: "메인", viewModel: self)
            let scene = MainScene.main(viewModel)

            return self.sceneCoordinator.transition(to: scene, using: .root, animated: true).asObservable().map { _ in }
        }
    }
}
