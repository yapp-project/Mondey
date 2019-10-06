//
//  SceneCoordinatorType.swift
//  XX
//
//  Created by Seonghun Kim on 06/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import Foundation

protocol SceneCoordinatorType {
    
    @discardableResult
    func transition(to scene: SceneType, using style: TransitionStyle, animated: Bool) -> Completable
    
    @discardableResult
    func close(animated: Bool) -> Completable
}
