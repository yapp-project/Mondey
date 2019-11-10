//
//  SignInViewModel.swift
//  XX
//
//  Created by Seonghun Kim on 06/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import Foundation

class SignInViewModel: BaseViewModel {
    let emailTextRelay = BehaviorRelay(value: "")
    let passwordTextRelauy = BehaviorRelay(value: "")
    
    func presentSignUpAction() -> CocoaAction {
        return CocoaAction { _ in
            let viewModel = SignUpViewModel(title: "회원가입", sceneCoordinator: self.sceneCoordinator, storage: self.storage)
            let scene = LoginScene.signUp(viewModel)
            
            return self.sceneCoordinator.transition(to: scene, using: .push, animated: true).asObservable().map { _ in }
        }
    }
    
    func presentSignInAction() -> CocoaAction {
        return CocoaAction { _ in
            let viewModel = IncomeSettingViewModel(title: "수입입력", sceneCoordinator: self.sceneCoordinator, storage: self.storage)
            let scene = SignUpSettingScene.income(viewModel)
            
            return self.sceneCoordinator.transition(to: scene, using: .root, animated: true).asObservable().map { _ in }
        }
    }
}
