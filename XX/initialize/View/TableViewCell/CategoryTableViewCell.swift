//
//  CategoryTableViewCell.swift
//  XX
//
//  Created by Seonghun Kim on 2019/11/02.
//  Copyright © 2019 YAPP. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    static let reuseIdentifier = "CategoryTableViewCell"

    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    var viewModel: CategoryTableViewCellViewModel?
}

extension CategoryTableViewCell: InitializeCellBindableType {
    func bindViewModel() {
        guard let viewModel = viewModel else { return }
        
        viewModel.category
            .map { $0.title }
            .bind(to: titleLabel.rx.text)
            .disposed(by: viewModel.rx.disposeBag)
        
        viewModel.category
            .map { $0.subTitle }
            .bind(to: subTitleLabel.rx.text)
            .disposed(by: viewModel.rx.disposeBag)
        
        viewModel.category
            .map { $0.active }
            .bind(to: checkButton.rx.isSelected)
            .disposed(by: viewModel.rx.disposeBag)
    }
}
