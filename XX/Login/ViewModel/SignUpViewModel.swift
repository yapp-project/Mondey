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
    
    let showIndicator = BehaviorRelay(value: false)

    func isPasswordValid() -> Observable<Bool> {
        return Observable.combineLatest(passwordTextRelay, checkPasswordTextRelay, resultSelector: checkPassword)
            .distinctUntilChanged()
    }
    
    func isValidateEmail() -> Observable<Bool> {
        return emailTextRelay
            .flatMap { [unowned self] in Observable.just(self.checkEmail($0)) }
    }
    
    func isSignUpValid() -> Observable<Bool> {
        return Observable.combineLatest(
            isValidateEmail(),
            isPasswordValid(),
            resultSelector: { $0 && $1 }
        )
    }
    
    private func checkEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
    private func checkPassword(_ p1: String, p2: String) -> Bool {
        return (p1 == p2)
    }
    
    func signUpAction() -> CocoaAction {
        return Action { [unowned self] action in
            return Observable.just(action)
                .withLatestFrom(self.isSignUpValid())
                .flatMap(self.checkSignUpAction().execute)
        }
    }
    
    private func checkSignUpAction() -> Action<Bool, Void> {
        return Action { [unowned self] valid in
            return valid ? self.requestSignUp() : self.shwoAlert()
        }
    }
    
    private func shwoAlert() -> Observable<Void> {
        sceneCoordinator.showWarning(title: "로그인 실패", message: "이메일과 비밀번호를 다시 확인해 주세요")
        return Observable.empty()
    }
    
    private func requestSignUp() -> Observable<Void> {
        self.showIndicator.accept(true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.showIndicator.accept(false)
            let viewModel = IncomeSettingViewModel(title: "수입입력", sceneCoordinator: self.sceneCoordinator, storage: self.storage)
            let scene = SignUpSettingScene.income(viewModel)
            
            self.sceneCoordinator.transition(to: scene, using: .root, animated: true)
        }
        
        return Observable.empty()
    }
}
