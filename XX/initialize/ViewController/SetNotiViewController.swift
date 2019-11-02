//
//  SetNotiViewController.swift
//  XX
//
//  Created by Seonghun Kim on 19/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import UIKit

class SetNotiViewController: UIViewController {
    
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var alertButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var viewModel: SetNotiViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        setButton()
    }

}

extension SetNotiViewController {
    private func setButton() {
        nextButton.layer.cornerRadius = 22
    }
}

extension SetNotiViewController: ViewModelBindableType {
    func bindViewModel() {
        guard let viewModel = viewModel else { return }
        
        nextButton.rx.action = viewModel.presentFinishAction()
    }
}

