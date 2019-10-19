//
//  SignInViewController.swift
//  XX
//
//  Created by Seonghun Kim on 29/09/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import UIKit

class SignInViewController: BaseViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var singUpButton: UIButton!
    
    var viewModel: SignInViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTextField()
        setButton()
    }
}

extension SignInViewController: ViewModelBindableType {
    func bindViewModel() {
        guard let viewModel = viewModel else { return }
        signInButton.rx.action = viewModel.presentSignInAction()
        singUpButton.rx.action = viewModel.presentSignUpAction()
        
        emailTextField.rx.text.orEmpty
            .bind(to: viewModel.emailTextRelay)
            .disposed(by: rx.disposeBag)
        passwordTextField.rx.text.orEmpty
            .bind(to: viewModel.passwordTextRelauy)
            .disposed(by: rx.disposeBag)
    }
}

extension SignInViewController {
    private func setTextField() {
        emailTextField.layer.borderColor = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
        emailTextField.layer.borderWidth = 1
        
        passwordTextField.layer.borderColor = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
        passwordTextField.layer.borderWidth = 1
    }
    
    private func setButton() {
        signInButton.layer.cornerRadius = 19.5
    }
}
