//
//  MainHeaderCollectionViewCell.swift
//  XX
//
//  Created by 박은비 on 27/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import UIKit

class MainHeaderCollectionViewFirstCell: UICollectionViewCell {
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var okButton: UIButton!
    
    @IBOutlet weak var howLabel: UILabel!
    @IBOutlet weak var howButton: UIButton!
    @IBOutlet weak var whatTextField: UITextField!
    @IBOutlet weak var moneyTextField: UITextField!
    
    var viewModel: MainViewModel? = nil{
        didSet{
            bindViewModel()
        }
    }
}

extension MainHeaderCollectionViewFirstCell: ViewModelBindableType {
    func bindViewModel() {
        guard let viewModel = viewModel else { return }
        
        MondeyHelper.shared.mondeyMainHeaderClean = { [unowned self] in
            viewModel.selectedMainPicker.accept(.init())
            
            // 등록되었습니다 알럿반영.
            UIAlertController
                .alert(title: "",
                       message: "등록되었습니다.",
                       style: .alert)
                .action(title: "확인", style: .default) { _ in  }
                .present(to: MondeyHelper.getTopViewController() )
            
            //혹시 모르니깐.. 얘네도 초기화
            viewModel.whatTextField.accept("")
            viewModel.moneyTextField.accept("")
            
            self.whatTextField.text = ""
            self.moneyTextField.text = ""
        }
        
        okButton.rx.action = viewModel.requestMainHeaderCellOkAction()
        howButton.rx.action = viewModel.requestMainHeaderisMainTicker()
         
        
        viewModel.selectedMainPicker.subscribe{[unowned self] (value) in
            if value.element?.title == nil || value.element?.title == "" { 
                self.howLabel.text = value.element?.name == "" ? "카테고리" : value.element?.name
            } else {
                self.howLabel.text = value.element?.title
            }}.disposed(by: rx.disposeBag)
        
        whatTextField.rx.text.orEmpty
            .bind(to: viewModel.whatTextField)
            .disposed(by: rx.disposeBag)
        
        moneyTextField.rx.text.orEmpty
            .bind(to: viewModel.moneyTextField)
            .disposed(by: rx.disposeBag)
        
        
    }
}
    

class MainHeaderCollectionViewSecondCell: UICollectionViewCell {
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var rightView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setLayout()
    }
    
    func setLayout() {
        self.rightView.setCorner(cornerRadius: 20)
    }
}

