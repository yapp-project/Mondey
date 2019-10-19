//
//  PickYearViewController.swift
//  XX
//
//  Created by 이재은 on 19/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import UIKit

class PickYearViewController: BaseViewController {

    var viewModel: PickYearViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

extension PickYearViewController: ViewModelBindableType {

    func bindViewModel() {
        guard let viewModel = viewModel else { return }
        
    }
}
