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
            
            #warning("임시로 로그인화면으로 연결, 메인화면 구현 후 메인으로 넘어갈 수 있도록 변경")
            let viewModel = SignInViewModel(title: "로그인", viewModel: self)
            let scene = LoginScene.signIn(viewModel)
            
            return self.sceneCoordinator.transition(to: scene, using: .root, animated: true).asObservable().map { _ in }
        }
    }
}
