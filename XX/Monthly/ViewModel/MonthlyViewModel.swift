//
//  MonthlyViewModel.swift
//  XX
//
//  Created by 이재은 on 06/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import Foundation

class MonthlyViewModel: BaseViewModel {
    
    func presentingSelectYear() -> CocoaAction {
        return CocoaAction { _ in
            let viewModel = PickYearViewModel(title: "날짜 선택",
                                             sceneCoordinator: self.sceneCoordinator,
                                             storage: self.storage)
            let scene = MonthlyScene.PickYear(viewModel)
            return self.sceneCoordinator.transition(to: scene,
                                                    using: .modal,
                                                    animated: true)
                .asObservable().map { _ in }
        }
    }
    
}
