//
//  SignInViewModel.swift
//  XX
//
//  Created by Seonghun Kim on 06/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import Foundation

class SignInViewModel: BaseViewModel {
    func presentSignUpAction() -> CocoaAction {
        return CocoaAction { _ in
            let viewModel = SignUpViewModel(title: "회원가입", sceneCoordinator: self.sceneCoordinator, storage: self.storage)
            let scene = LoginScene.signUp(viewModel)
            
            return self.sceneCoordinator.transition(to: scene, using: .modal, animated: true).asObservable().map { _ in }
        }
    }
}
