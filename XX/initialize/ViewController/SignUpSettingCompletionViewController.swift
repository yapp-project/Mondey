//
//  FinishInitViewController.swift
//  XX
//
//  Created by Seonghun Kim on 19/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import UIKit

class SignUpSettingCompletionViewController: BaseViewController {
    
    @IBOutlet weak var startButton: UIButton!
    
    var viewModel: SignUpSettingCompletionViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setButton()
    }
    
}

extension SignUpSettingCompletionViewController {
    private func setButton() {
        startButton.layer.cornerRadius = 22
    }
}


extension SignUpSettingCompletionViewController: ViewModelBindableType {
    func bindViewModel() {
        guard let viewModel = viewModel else { return }
        
        startButton.rx.action = viewModel.presentMainAction()
    }
}

