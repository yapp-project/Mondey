//
//  SetNotiViewModel.swift
//  XX
//
//  Created by Seonghun Kim on 19/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import Foundation

class NotiSettingViewModel: BaseViewModel {
    func presentFinishAction() -> CocoaAction {
        return CocoaAction { _ in
            let viewModel = FinishInitViewModel(title: "설정완료", viewModel: self)
            let scene = SignUpSettingScene.finish(viewModel)
            
            return self.sceneCoordinator.transition(to: scene, using: .modal, animated: true).asObservable().map { _ in }
        }
    }
}
