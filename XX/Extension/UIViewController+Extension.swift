//
//  UIViewController+Extension.swift
//  XX
//
//  Created by Seonghun Kim on 06/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import UIKit

extension UIViewController {
    var sceneViewController: UIViewController {
        return self.children.first ?? self
    }
}
