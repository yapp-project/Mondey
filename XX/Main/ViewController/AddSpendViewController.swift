//
//  AddSpendViewController.swift
//  XX
//
//  Created by 박은비 on 19/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import UIKit

class AddSpendViewController: BaseViewController {
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    var viewModel: AddSpendViewModel?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

extension AddSpendViewController: ViewModelBindableType {
    func bindViewModel() {
        guard let viewModel = viewModel else { return }
        backButton.rx.action = viewModel.requestBackButtonAction()
    }
}
