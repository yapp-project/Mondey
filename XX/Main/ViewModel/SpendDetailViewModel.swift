//
//  SpendViewModel.swift
//  XX
//
//  Created by 박은비 on 19/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import UIKit

class SpendDetailViewModel: BaseViewModel {
    var spendDetailCategory = BehaviorRelay<Category>(value: .init())
    
    func requestBackButtonAction() -> CocoaAction {
        return Action { _ in
            return self.sceneCoordinator.close(animated: true).asObservable().map { _ in }
        }
    }
}
