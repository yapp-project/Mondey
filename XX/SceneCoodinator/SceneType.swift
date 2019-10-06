//
//  SceneType.swift
//  XX
//
//  Created by Seonghun Kim on 06/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import UIKit

protocol SceneType {
    func instantiate(from storyboard: String) -> UIViewController
    func instantiate() -> UIViewController
}
