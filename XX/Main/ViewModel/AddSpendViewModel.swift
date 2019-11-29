//
//  AddSpendViewModel.swift
//  XX
//
//  Created by 박은비 on 19/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import UIKit

class AddSpendViewModel: BaseViewModel {
    
    // 보이기용
    var categoryValue = BehaviorRelay<String?>(value: .init())
    var subCategoryValue = BehaviorRelay<String>(value: .init())
    var selectCategoryHeight = BehaviorRelay<CGFloat>(value: .init())
    var selectCategoryAlpha = BehaviorRelay<CGFloat>(value: .init())
    
    var nameTextField = BehaviorRelay<String?>(value: .init())
    var moneyTextField = BehaviorRelay<String?>(value: .init())
    
    // 저장용
    var categoryIdx: Int? = nil
    
    func requestBackButtonAction() -> CocoaAction {
        return Action { [unowned self] _ in
            return self.sceneCoordinator.close(animated: true).asObservable().map { _ in }
        }
    }
    
    func requestSaveButtonAction(name: String?,
                                 money: String?)-> CocoaAction {
        return Action { [unowned self] action in
            
            if self.categoryIdx == nil ||
                self.nameTextField.value == nil || self.nameTextField.value == "" ||
                self.moneyTextField.value == nil || self.moneyTextField.value == "" {
                UIAlertController
                    .alert(title: "오류",
                           message: "값을 확인해주세요",
                           style: .alert)
                    .action(title: "확인", style: .default) { _ in
                        return Observable.just(action)
                    }
                    .present(to: MondeyHelper.getTopViewController() )
                
                return Observable.just(action)
            } else {
                // 메인 카테고리에 값 추가 해야함.
                if let closure = MondeyHelper.shared.mondeyMainAddHelper {
                    
                    let categories = MemoryStorage.shared.categories
                    let currentBigId = categories.map{ $0.id }.sorted(by: { $0 < $1 } ).last
                    
                    // 현재에서 제일 큰 카테고리 아이디를 들고와서 그것보다 +1 시켜줌으로써 유니크 키를 유지시켜줌
                    closure(self.categoryIdx!, currentBigId! + 1, self.nameTextField.value!, (Int(self.moneyTextField.value!)! * 10000) )
                    
                    return self.sceneCoordinator.close(animated: true).asObservable().map { _ in }
                }
            }
            
            return Observable.just(action)
        }
    }
    
    func requestCategoryAction(idx: Int,
                               category: String?,
                               subCategory: String) -> CocoaAction {
        return Action { [unowned self] action in
            self.categoryIdx = idx
            self.selectCategoryHeight.accept(0)
            self.selectCategoryAlpha.accept(0)
            
            self.nameTextField.accept(category)
            
            self.categoryValue.accept(category)
            self.subCategoryValue.accept(subCategory)
            
            
            return Observable.just(action)
        }
    }
}
