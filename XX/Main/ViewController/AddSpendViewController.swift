//
//  AddSpendViewController.swift
//  XX
//
//  Created by 박은비 on 19/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import UIKit

class AddSpendViewController: BaseViewController {
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var categoryHeight: NSLayoutConstraint!
    @IBOutlet weak var categoryView: UIView!
    
    
    var viewModel: AddSpendViewModel?
    
    // 임시, 이후에 Rx로 바꾸기
    @IBAction func imsiCategoryAnimationBtnDidTap(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            self.categoryHeight.constant = self.categoryHeight.constant == 0 ? 470 : 0
            self.categoryView.alpha = self.categoryView.alpha == 0 ? 1 : 0
            self.categoryView.layoutIfNeeded()
            self.view.layoutIfNeeded()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

extension AddSpendViewController: ViewModelBindableType {
    func bindViewModel() {
        guard let viewModel = viewModel else { return }
        backButton.rx.action = viewModel.requestBackButtonAction()
        saveButton.rx.action = viewModel.requestBackButtonAction()
    }
}
