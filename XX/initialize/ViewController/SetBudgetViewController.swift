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

        setTableView()
        setButton()
    }
}

extension SetBudgetViewController {
    private func setTableView() {
        tableView.keyboardDismissMode = .onDrag
        tableView.alwaysBounceVertical = false
    }
    
    private func setButton() {
        nextButton.layer.cornerRadius = 22
    }
}

extension SetBudgetViewController: ViewModelBindableType {
    func bindViewModel() {
        guard let viewModel = viewModel else { return }
        
        viewModel.title
            .drive(navigationItem.rx.title)
            .disposed(by: rx.disposeBag)
        
        viewModel.categoryList()
            .bind(to: tableView.rx.items(cellIdentifier: BudgetTableViewCell.reuseIdentifier))
            { row, category, cell in
                guard var cell = cell as? BudgetTableViewCell else { return }
                
                let viewModel = BudgetTableViewCellViewModel()
                viewModel.category.accept(category)
                cell.bind(viewModel: viewModel)
                
                self.viewModel?.addSubViewModels(index: row, subViewModel: viewModel)
            }
            .disposed(by: rx.disposeBag)
        
        nextButton.rx.action = viewModel.presentPeriodAction()
        
        viewModel.incomeString()
            .bind(to: budgetLabel.rx.text)
            .disposed(by: rx.disposeBag)
        
        viewModel.totalBudget()
            .bind(to: savingLabel.rx.text)
            .disposed(by: rx.disposeBag)
    }
}

