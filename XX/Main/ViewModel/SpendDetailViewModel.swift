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
    
    let sectionListSubject = BehaviorSubject(value: [SectionModel(model: "First section", items: [Expenditure].init())]) // spendDetailCategory 세팅 이후에 세팅되어야하
    
    var selectedDate        = BehaviorRelay<Date>(value: Date())
    var selectedString      = BehaviorRelay<String>(value: MondeyHelper.nowDate())
    
    func requestBackButtonAction() -> CocoaAction {
        return Action { _ in
            return self.sceneCoordinator.close(animated: false).asObservable().map { _ in }
        }
    }
    
    func requestDatePickerAction()-> CocoaAction {
        return Action { _ in
            let scene = MainScene.spendChoiceModal(self)
            
            return self
                .sceneCoordinator
                .transition(to: scene,
                            using: .modal,
                            animated: false)
                .asObservable().map { _ in }
        }
    }
    
    
    // 날짜 선택 뷰
    func requestAppendSobiButtonAction()-> CocoaAction {
        return Action { [unowned self] _ in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM월 dd일"
            self.selectedString.accept(dateFormatter.string(from: self.selectedDate.value))
            
            return self.sceneCoordinator.close(animated: false).asObservable().map { _ in }
        }
    }
    
}
