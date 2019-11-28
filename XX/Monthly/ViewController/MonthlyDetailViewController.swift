//
//  MonthlyDetailViewController.swift
//  XX
//
//  Created by 이재은 on 19/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import UIKit

class MonthlyDetailViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var gradeImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var usedLabel: UILabel!
    @IBOutlet weak var budgetLabel: UILabel!

    var viewModel: MonthlyDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        setTableView()

    }
    
}

extension MonthlyViewController {
    private func setTableView() {
//        tableView.keyboardDismissMode = .onDrag
//        tableView.alwaysBounceVertical = false
    }

}

extension MonthlyDetailViewController: ViewModelBindableType {
    
    func bindViewModel() {
        guard let viewModel = viewModel else { return }

        leftButton.rx.action = viewModel.showPreviousMonthAction()
        rightButton.rx.action = viewModel.showNextMonthAction()
    }
}


//
//extension CategoriesSettingViewController: ViewModelBindableType {
//    func bindViewModel() {
//        guard let viewModel = viewModel else { return }
//
//        viewModel.categories
//            .bind(to: tableView.rx.items(cellIdentifier: CategoryTableViewCell.reuseIdentifier))
//            { row, category, cell in
//                guard var cell = cell as? CategoryTableViewCell else { return }
//
//                let viewModel = CategorySettingCellViewModel()
//                viewModel.category.accept(category)
//                cell.bind(viewModel: viewModel)
//            }
//            .disposed(by: rx.disposeBag)
//
//        tableView.rx.itemSelected
//            .map { $0.row }
//            .subscribe(onNext: viewModel.selectItem)
//            .disposed(by: rx.disposeBag)
//
//        nextButton.rx.action = viewModel.presentBudgetAction()
//
//        viewModel.incomeString()
//            .bind(to: budgetLabel.rx.text)
//            .disposed(by: rx.disposeBag)
//
//        viewModel.validSetting()
//            .do(onNext: { [unowned self] in
//                self.nextButton.backgroundColor = $0 ? UIColor(named: "tealish") : UIColor(named: "153")
//            })
//            .bind(to: nextButton.rx.isEnabled)
//            .disposed(by: rx.disposeBag)
//    }
//}

