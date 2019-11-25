//
//  MDListTableViewCell.swift
//  XX
//
//  Created by 이재은 on 24/11/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import UIKit

class MDListTableViewCell: UITableViewCell {
    static let reuseIdentifier = "MDListTableViewCell"

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var usedLabel: UILabel!
    @IBOutlet weak var budgetLabel: UILabel!


    var viewModel: MDListCellViewModel?

    override func prepareForReuse() {
        super.prepareForReuse()

        viewModel = nil
        iconImageView.image = nil
        titleLabel.text = nil
        usedLabel.text = nil
        budgetLabel.text = nil
    }
}

extension MDListTableViewCell: MDCellBindableType {
    func bindViewModel() {
        guard let viewModel = viewModel else { return }



    }
}

//extension BudgetTableViewCell: SignUpSettingCellBindableType {
//    func bindViewModel() {
//        guard let viewModel = viewModel else { return }
//
//        viewModel.category
//            .map { $0.title }
//            .bind(to: titleLabel.rx.text)
//            .disposed(by: viewModel.rx.disposeBag)
//
//        viewModel.category
//            .map { $0.subTitle }
//            .bind(to: subTitleLabel.rx.text)
//            .disposed(by: viewModel.rx.disposeBag)
//
//        viewModel.category
//            .map { $0.budgetString }
//            .bind(to: budgetTextField.rx.text)
//            .disposed(by: viewModel.rx.disposeBag)
//
//        budgetTextField.rx.text.orEmpty
//            .distinctUntilChanged()
//            .bind(to: viewModel.budgetText)
//            .disposed(by: viewModel.rx.disposeBag)
//}

//extension CategoryTableViewCell: SignUpSettingCellBindableType {
//    func bindViewModel() {
//        guard let viewModel = viewModel else { return }
//
//        viewModel.category
//            .map { $0.title }
//            .bind(to: titleLabel.rx.text)
//            .disposed(by: viewModel.rx.disposeBag)
//
//        viewModel.category
//            .map { $0.subTitle }
//            .bind(to: subTitleLabel.rx.text)
//            .disposed(by: viewModel.rx.disposeBag)
//
//        viewModel.category
//            .map { $0.active }
//            .bind(to: checkButton.rx.isSelected)
//            .disposed(by: viewModel.rx.disposeBag)
//    }
//}
