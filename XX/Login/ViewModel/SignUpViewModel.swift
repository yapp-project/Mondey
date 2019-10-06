//
//  SignUpViewModel.swift
//  XX
//
//  Created by Seonghun Kim on 06/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import Foundation

class SignUpViewModel: BaseViewModel {
    
    func requestSignUpAction() -> CocoaAction {
        return Action { _ in
            return self.sceneCoordinator.close(animated: true).asObservable().map { _ in }
        }
    }
}
