//
//  BaseViewController.swift
//  XX
//
//  Created by Seonghun Kim on 29/09/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
         
        let tapGest = UITapGestureRecognizer()
        view.addGestureRecognizer(tapGest)
        
        tapGest.rx.event.bind { (recognizer) in
            self.view.endEditing(true)
            }.disposed(by: rx.disposeBag)
    } 
}
