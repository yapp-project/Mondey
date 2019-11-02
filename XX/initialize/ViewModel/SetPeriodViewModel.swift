//
//  SetPeriod.swift
//  XX
//
//  Created by Seonghun Kim on 19/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import Foundation

class SetPeriodViewModel: BaseViewModel {
    func presentNotiSettingAction() -> CocoaAction {
        return CocoaAction { _ in
            let viewModel = SetNotiViewModel(title: "알림설정", viewModel: self)
            let scene = InitializeScene.notiSetting(viewModel)
            
            return self.sceneCoordinator.transition(to: scene, using: .push, animated: true).asObservable().map { _ in }
        }
    }
}
