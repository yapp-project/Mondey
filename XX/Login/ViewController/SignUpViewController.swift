//
//  SignUpViewController.swift
//  XX
//
//  Created by Seonghun Kim on 29/09/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import UIKit

class SignUpViewController: BaseViewController {
    
    @IBOutlet weak var SignUpButton: UIButton!
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var checkPasswordTextField: UITextField!
    
    var viewModel: SignUpViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setButton()
    }
}

extension SignUpViewController: ViewModelBindableType {
    func bindViewModel() {
        guard let viewModel = viewModel else { return }

        emailTextField.rx.text.orEmpty
            .bind(to: viewModel.emailTextRelay)
            .disposed(by: rx.disposeBag)
        passwordTextField.rx.text.orEmpty
            .bind(to: viewModel.passwordTextRelay)
            .disposed(by: rx.disposeBag)
        checkPasswordTextField.rx.text.orEmpty
            .bind(to: viewModel.checkPasswordTextRelay)
            .disposed(by: rx.disposeBag)
        
        viewModel.isPasswordValid()
            .bind(to: warningLabel.rx.isHidden)
            .disposed(by: rx.disposeBag)
        
        SignUpButton.rx.action = viewModel.signUpAction()
    }
}

extension SignUpViewController {
    func setButton() {
        SignUpButton.layer.cornerRadius = 19.5
        SignUpButton.clipsToBounds = true
    }
}
