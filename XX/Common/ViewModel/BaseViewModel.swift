//
//  CommonViewModel.swift
//  XX
//
//  Created by Seonghun Kim on 06/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import Foundation

class BaseViewModel: NSObject {
    let title: Driver<String>
    let sceneCoordinator: SceneCoordinatorType
    let storage: StorageType
    
    init(title: String, sceneCoordinator: SceneCoordinatorType, storage: StorageType) {
        self.title = Observable.just(title).asDriver(onErrorJustReturn: "")
        self.sceneCoordinator = sceneCoordinator
        self.storage = storage
    }
    
    init(title: String = "", viewModel: BaseViewModel) {
        self.title = Observable.just(title).asDriver(onErrorJustReturn: "")
        self.sceneCoordinator = viewModel.sceneCoordinator
        self.storage = viewModel.storage
    }
}
