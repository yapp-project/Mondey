//
//  PickYearViewModel.swift
//  XX
//
//  Created by 이재은 on 19/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import Foundation

class PickYearViewModel: BaseViewModel {

    func requestCloseButtonAction() -> CocoaAction {
        return Action { _ in
            return self.sceneCoordinator.close(animated: false).asObservable().map { _ in }
        }
    }

    func selectItem() {
        
    }

    func saveSelectedYear(_ year: Int) {

    }
}
