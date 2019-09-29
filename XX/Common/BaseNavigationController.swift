//
//  BaseNavigationController.swift
//  XX
//
//  Created by Seonghun Kim on 29/09/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.tintColor = #colorLiteral(red: 0.5564265847, green: 0.9294613004, blue: 0.7571136951, alpha: 1)
        
        navigationBar.backIndicatorImage = .backButton
        navigationBar.backIndicatorTransitionMaskImage = .backButton
        
        let backItem = UIBarButtonItem()
        backItem.title = nil
        navigationBar.topItem?.backBarButtonItem = backItem
    }
}
