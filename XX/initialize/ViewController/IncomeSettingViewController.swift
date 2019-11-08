//
//  IncomeViewController.swift
//  XX
//
//  Created by Seonghun Kim on 19/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import UIKit

class IncomeSettingViewController: BaseViewController {
    
    @IBOutlet weak var incomeTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    var viewModel: IncomeSettingViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setButton()
    }
}

extension IncomeSettingViewController {
    private func setButton() {
        nextButton.layer.cornerRadius = 22
    }
}

extension IncomeSettingViewController: ViewModelBindableType {
    func bindViewModel() {
        guard let viewModel = viewModel else { return }
        
        view.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [unowned self] _ in
                self.view.endEditing(true)
            })
            .disposed(by: rx.disposeBag)
        
        incomeTextField.rx.text.orEmpty
            .bind(to: viewModel.incomeText)
            .disposed(by: rx.disposeBag)
        
        viewModel.incomeString()
            .bind(to: incomeTextField.rx.text)
            .disposed(by: rx.disposeBag)
        
        nextButton.rx.action = viewModel.presentCategoriesAction()
    }
}
