//
//  IncomeViewController.swift
//  XX
//
//  Created by Seonghun Kim on 19/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import UIKit

class IncomeViewController: UIViewController {
    
    @IBOutlet weak var incomeTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    var viewModel: IncomeViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setButton()
    }
}

extension IncomeViewController {
    private func setButton() {
        nextButton.layer.cornerRadius = 22
    }
}

extension IncomeViewController: ViewModelBindableType {
    func bindViewModel() {
        guard let viewModel = viewModel else { return }
        
        incomeTextField.rx.text.orEmpty
            .bind(to: viewModel.incomeText)
            .disposed(by: rx.disposeBag)
        
        nextButton.rx.action = viewModel.presentCategoriesAction()
    }
}
