//
//  SetNotiViewModel.swift
//  XX
//
//  Created by Seonghun Kim on 19/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import Foundation

class NotiSettingViewModel: BaseViewModel {
    var isAllowedOption = BehaviorRelay(value: true)
    
    func updateAlertOptionAction() -> CocoaAction {
        return CocoaAction { [unowned self] action in
            return Observable.just(action)
                .map(self.toggleAlertOption)
        }
    }
    
    func presentFinishAction() -> CocoaAction {
        return CocoaAction { _ in
            let viewModel = SignUpSettingCompletionViewModel(title: "설정완료", viewModel: self)
            let scene = SignUpSettingScene.finish(viewModel)
            
            return self.sceneCoordinator.transition(to: scene, using: .modal, animated: true).asObservable().map { _ in }
        }
    }
    
    private func toggleAlertOption() {
        isAllowedOption.accept(!isAllowedOption.value)
    }
}
