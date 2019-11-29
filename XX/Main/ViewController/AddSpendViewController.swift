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
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var useMoneyTextField: UITextField!
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var selectCategoryView: UIView!
    @IBOutlet weak var didSelectCategoryView: UIView!
    
    @IBOutlet weak var selectCategoryLabel: UILabel!
    @IBOutlet weak var selectSubCategoryLabel: UILabel!
    
    @IBOutlet weak var categoryHeight: NSLayoutConstraint!
    
    // 카테고리
    @IBOutlet weak var 식비Button: UIButton!
    @IBOutlet weak var 쇼핑Button: UIButton!
    @IBOutlet weak var 미용운동Button: UIButton!
    @IBOutlet weak var 교통Button: UIButton!
    @IBOutlet weak var 여가취미Button: UIButton!
    @IBOutlet weak var 고정비Button: UIButton!
    @IBOutlet weak var 기타Button: UIButton!
    
    // 하기 성훈님이 만든 데이터셋으로 변경
    let category = ["식비",
                    "쇼핑",
                    "미용/운동",
                    "교통/자동차",
                    "여가/취미",
                    "고정비",
                    "적금"]
    
    let subCategory = ["식사, 외식, 카페, 술, 장보기등",
                       "패션, 인터넷쇼핑등",
                       "건강, 헤어, 메이크업등",
                       "교통비, 자동차 비용등",
                       "여가, 취미, 문화생활등",
                       "경조사, 보험금, 공과금등",
                       "적금, 애완동물등"]
    
    
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
        
        viewModel.categoryValue
            .subscribe({ (value) in
                print("value \(value)")
                if value.element != "" {
                    DispatchQueue.main.async {
                        self.selectCategoryView.isHidden = true
                    }
                }
            })
            .disposed(by: viewModel.rx.disposeBag)
        
        
        viewModel.categoryValue
            .bind(to: selectCategoryLabel.rx.text)
            .disposed(by: viewModel.rx.disposeBag)
        
        viewModel.subCategoryValue
            .bind(to: selectSubCategoryLabel.rx.text)
            .disposed(by: viewModel.rx.disposeBag)
        
        viewModel.selectCategoryAlpha
            .bind(to: self.categoryView.rx.alpha )
            .disposed(by: viewModel.rx.disposeBag)
        
        viewModel.selectCategoryHeight
            .bind(to: self.categoryHeight.rx.constant )
            .disposed(by: viewModel.rx.disposeBag)
        
        backButton.rx.action = viewModel.requestBackButtonAction()
        
         
        saveButton.rx.action = viewModel.requestSaveButtonAction(name:  self.nameTextField.text,
                                                                 money: self.useMoneyTextField.text)
        viewModel.nameTextField
            .subscribe({[unowned self] (value) in 
                if let value = value.element {
                    self.nameTextField.text = value
                }
            })
            .disposed(by: viewModel.rx.disposeBag)
        
        nameTextField.rx.text.orEmpty
            .bind(to: viewModel.nameTextField)
            .disposed(by: rx.disposeBag)
        
        useMoneyTextField.rx.text.orEmpty
            .bind(to: viewModel.moneyTextField)
            .disposed(by: rx.disposeBag)
        
        식비Button.rx.action = viewModel.requestCategoryAction(idx: 1, category: category[0], subCategory: subCategory[0])
        쇼핑Button.rx.action = viewModel.requestCategoryAction(idx: 2, category: category[1], subCategory: subCategory[1])
        미용운동Button.rx.action = viewModel.requestCategoryAction(idx: 3, category: category[2], subCategory: subCategory[2])
        교통Button.rx.action = viewModel.requestCategoryAction(idx: 4, category: category[3], subCategory: subCategory[3])
        여가취미Button.rx.action = viewModel.requestCategoryAction(idx: 5, category: category[4], subCategory: subCategory[4])
        고정비Button.rx.action = viewModel.requestCategoryAction(idx: 6, category: category[5], subCategory: subCategory[5])
        기타Button.rx.action = viewModel.requestCategoryAction(idx: 7, category: category[6], subCategory: subCategory[6])
        
        

    }
}
