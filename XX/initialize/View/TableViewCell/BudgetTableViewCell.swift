//
//  BudgetTableViewCell.swift
//  XX
//
//  Created by Seonghun Kim on 2019/11/02.
//  Copyright © 2019 YAPP. All rights reserved.
//

import UIKit

class BudgetTableViewCell: UITableViewCell {
    static let reuseIdentifier = "BudgetTableViewCell"

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var budgetTextField: UITextField!
    
    var viewModel: BudgetTableViewCellViewModel?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        viewModel = nil
        titleLabel.text = nil
        subTitleLabel.text = nil
        budgetTextField.text = nil
    }
}

extension BudgetTableViewCell: InitializeCellBindableType {
    func bindViewModel() {
        guard let viewModel = viewModel else { return }
        
        contentView.rx.tapGesture()
            .when(.recognized)
            .materialize()
            .filter { $0.error == nil }
            .dematerialize()
            .subscribe(onNext: { [unowned self] _ in
                self.budgetTextField.becomeFirstResponder()
            })
            .disposed(by: viewModel.rx.disposeBag)
        
        viewModel.category
            .map { $0.title }
            .bind(to: titleLabel.rx.text)
            .disposed(by: viewModel.rx.disposeBag)
        
        viewModel.category
            .map { $0.subTitle }
            .bind(to: subTitleLabel.rx.text)
            .disposed(by: viewModel.rx.disposeBag)
        
        viewModel.category
            .map { $0.budgetString }
            .bind(to: budgetTextField.rx.text)
            .disposed(by: viewModel.rx.disposeBag)
        
        budgetTextField.rx.text.orEmpty
            .distinctUntilChanged()
            .bind(to: viewModel.budgetText)
            .disposed(by: viewModel.rx.disposeBag)
    }
}

