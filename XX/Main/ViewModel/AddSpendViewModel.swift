//
//  AddSpendViewModel.swift
//  XX
//
//  Created by 박은비 on 19/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import UIKit

class AddSpendViewModel: BaseViewModel {
    var categoryValue = BehaviorRelay<String?>(value: .init())
    var subCategoryValue = BehaviorRelay<String>(value: .init())
    var selectCategoryHeight = BehaviorRelay<CGFloat>(value: .init())
    var selectCategoryAlpha = BehaviorRelay<CGFloat>(value: .init())
    
    func requestBackButtonAction() -> CocoaAction {
        return Action { [unowned self] _ in
            return self.sceneCoordinator.close(animated: true).asObservable().map { _ in }
        }
    }
    
    func requestCategoryAction(category: String,
                               subCategory: String) -> CocoaAction {
        return Action { [unowned self] action in
            self.selectCategoryHeight.accept(0)
            self.selectCategoryAlpha.accept(0)
            
            self.categoryValue.accept(category)
            self.subCategoryValue.accept(subCategory)
            
            
            return Observable.just(action)
        }
    }
}
