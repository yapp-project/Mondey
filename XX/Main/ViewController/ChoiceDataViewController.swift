//
//  ChoiceDataViewController.swift
//  XX
//
//  Created by 박은비 on 24/11/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import UIKit

class ChoiceDataViewController: BaseViewController {
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var okButton: UIButton!
    
    var viewModel: MainViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setLayout()
    }
    
    func setLayout() {
        self.backView.setCorner(cornerRadius: 10)
    }
}

extension ChoiceDataViewController: ViewModelBindableType{
    func bindViewModel() {
        guard let viewModel = viewModel else { return }
        closeButton.rx.action = viewModel.requestBackButtonAction()
//        closeButton.rx.action = viewModel.requestBackButtonAction()
    }
}
