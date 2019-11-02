//
//  SetPeriodViewController.swift
//  XX
//
//  Created by Seonghun Kim on 19/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import UIKit

class SetPeriodViewController: UIViewController {
    
    @IBOutlet weak var dayButton: UIButton!
    @IBOutlet weak var weekButton: UIButton!
    @IBOutlet weak var monthButton: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!
    
    var viewModel: SetPeriodViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        setButton()
    }

}

extension SetPeriodViewController {
    private func setButton() {
        nextButton.layer.cornerRadius = 22
    }
}

extension SetPeriodViewController: ViewModelBindableType {
    func bindViewModel() {
        guard let viewModel = viewModel else { return }
        
        nextButton.rx.action = viewModel.presentNotiSettingAction()
    }
}
