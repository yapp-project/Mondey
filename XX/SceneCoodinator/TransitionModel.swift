//
//  TransitionModel.swift
//  XX
//
//  Created by Seonghun Kim on 06/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import Foundation

enum TransitionStyle {
    case root
    case push
    case modal
}


enum TransitionError: Error {
    case navigationControllerMissing
    case cannotPop
    case unknown
}
