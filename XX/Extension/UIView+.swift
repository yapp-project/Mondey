//
//  UIView+.swift
//  XX
//
//  Created by 박은비 on 30/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import UIKit

extension UIView {
    func setCorner(cornerRadius: CGFloat) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = cornerRadius
    }
}
