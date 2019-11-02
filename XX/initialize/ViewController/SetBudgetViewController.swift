//
//  SetBudgetViewController.swift
//  XX
//
//  Created by Seonghun Kim on 19/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import UIKit

class SetBudgetViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet weak var savingLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    var viewModel: SetBudgetViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        setButton()
    }
}

extension SetBudgetViewController {
    private func setButton() {
        nextButton.layer.cornerRadius = 22
    }
}

extension SetBudgetViewController: ViewModelBindableType {
    func bindViewModel() {
        guard let viewModel = viewModel else { return }
        
        nextButton.rx.action = viewModel.presentPeriodAction()
    }
}

