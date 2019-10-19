//
//  SignUpViewModel.swift
//  XX
//
//  Created by Seonghun Kim on 06/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import Foundation

class SignUpViewModel: BaseViewModel {
    let emailTextRelay = BehaviorRelay(value: "")
    let passwordTextRelay = BehaviorRelay(value: "")
    let checkPasswordTextRelay = BehaviorRelay(value: "")
    let signUpButtonTap = PublishRelay<Void>()
    
    override init(title: String, sceneCoordinator: SceneCoordinatorType, storage: StorageType) {
        super.init(title: title, sceneCoordinator: sceneCoordinator, storage: storage)
        
        signUpButtonTap
            .subscribe(onNext: requestSignUp)
            .disposed(by: rx.disposeBag)
    }
    
    func isPasswordVaild() -> Observable<Bool> {
        return Observable.combineLatest(passwordTextRelay, checkPasswordTextRelay, resultSelector: checkPassword)
            .distinctUntilChanged()
    }
    
    private func checkPassword(_ p1: String, p2: String) -> Bool {
        return (p1 == p2)
    }
    
    func validateEmail(candidate: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: candidate)
    }
    
    private func requestSignUp() {
        guard validateEmail(candidate: emailTextRelay.value),
            checkPassword(passwordTextRelay.value, p2: checkPasswordTextRelay.value),
            !passwordTextRelay.value.isEmpty
            else { return }

        let viewModel = IncomeViewModel(title: "수입입력", sceneCoordinator: self.sceneCoordinator, storage: self.storage)
        let scene = InitializeScene.income(viewModel)
        
        sceneCoordinator.transition(to: scene, using: .root, animated: true)
    }
}
