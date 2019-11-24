//
//  SetBudgetViewController.swift
//  XX
//
//  Created by Seonghun Kim on 19/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import UIKit

class BudgetSettingViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet weak var savingLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    var viewModel: BudgetSettingViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableView()
        setButton()
    }
}

extension BudgetSettingViewController {
    private func setTableView() {
        tableView.keyboardDismissMode = .onDrag
        tableView.alwaysBounceVertical = false
    }
    
    private func setButton() {
        nextButton.layer.cornerRadius = 22
    }
}

extension BudgetSettingViewController: ViewModelBindableType {
    func bindViewModel() {
        guard let viewModel = viewModel else { return }
        
        view.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [unowned self] _ in
                self.view.endEditing(true)
            })
            .disposed(by: rx.disposeBag)
        
        viewModel.title
            .drive(navigationItem.rx.title)
            .disposed(by: rx.disposeBag)
        
        viewModel.categoryList()
            .bind(to: tableView.rx.items(cellIdentifier: BudgetTableViewCell.reuseIdentifier))
            { row, category, cell in
                guard var cell = cell as? BudgetTableViewCell else { return }
                
                let viewModel = self.viewModel(index: row, category: category)
                cell.bind(viewModel: viewModel)
            }
            .disposed(by: rx.disposeBag)
        
        nextButton.rx.action = viewModel.presentPeriodAction()
        
        viewModel.incomeString()
            .bind(to: budgetLabel.rx.text)
            .disposed(by: rx.disposeBag)
        
        viewModel.totalBudget()
            .map { "매달 \($0)만원 저축" }
            .bind(to: savingLabel.rx.text)
            .disposed(by: rx.disposeBag)
        
        viewModel.validSetting()
            .do(onNext: { [unowned self] in
                self.nextButton.backgroundColor = $0 ? UIColor(named: "tealish") : UIColor(named: "153")
            })
            .bind(to: nextButton.rx.isEnabled)
            .disposed(by: rx.disposeBag)
    }
    
    private func viewModel(index: Int, category: Category) -> BudgetSettingCellViewModel {
        if let viewModel = viewModel?.subViewModels[index] {
            return viewModel
        }
        
        let viewModel = BudgetSettingCellViewModel()
        viewModel.category.accept(category)
        self.viewModel?.addSubViewModels(index: index, subViewModel: viewModel)
        
        return viewModel
    }
}

