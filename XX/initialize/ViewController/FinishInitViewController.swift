//
//  FinishInitViewController.swift
//  XX
//
//  Created by Seonghun Kim on 19/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import UIKit

class FinishInitViewController: UIViewController {
    
    @IBOutlet weak var startButton: UIButton!
    
    var viewModel: FinishInitViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        setButton()
    }
    
}

extension FinishInitViewController {
    private func setButton() {
        startButton.layer.cornerRadius = 22
    }
}


extension FinishInitViewController: ViewModelBindableType {
    func bindViewModel() {
        guard let viewModel = viewModel else { return }
        
        startButton.rx.action = viewModel.presentMainAction()
    }
}

