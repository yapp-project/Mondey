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
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
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
        okButton.rx.action = viewModel.requestAppendSobiButtonAction(selectedDate: datePicker.date)
        
        
        print("datePicker \(datePicker.date)")
    }
    
}

/// ㅠㅠ설계 잘못해서 따로 한번더 만듬..
class SpendDetailDateSelectedPopupView: BaseViewController {
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var okButton: UIButton!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var viewModel: SpendDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        bindViewModel()
        setLayout()
    }
    
    func setLayout() {
        self.backView.setCorner(cornerRadius: 10)
    }
}

extension SpendDetailDateSelectedPopupView: ViewModelBindableType{
    func bindViewModel() {
        guard let viewModel = viewModel else { return }
        closeButton.rx.action = viewModel.requestBackButtonAction()
        
        datePicker.rx.date.bind(to: viewModel.selectedDate )
            .disposed(by: rx.disposeBag)
        okButton.rx.action = viewModel.requestAppendSobiButtonAction()
        
    }
    
}
