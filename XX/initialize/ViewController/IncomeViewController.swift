//
//  IncomeViewController.swift
//  XX
//
//  Created by Seonghun Kim on 19/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import UIKit

class IncomeViewController: UIViewController {
    
    var viewModel: IncomeViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension IncomeViewController: ViewModelBindableType {
    func bindViewModel() {
        guard let viewModel = viewModel else { return }
    }
}
