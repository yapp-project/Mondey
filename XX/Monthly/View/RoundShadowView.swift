//
//  RoundShadowView.swift
//  XX
//
//  Created by 이재은 on 30/11/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import UIKit

class RoundShadowView: UIView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.layer.cornerRadius = 11

        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowOpacity = 0.4
        self.layer.shadowRadius = 10.0
    }

}
