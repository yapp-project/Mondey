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

    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var usedLabel: UILabel!
    @IBOutlet private weak var budgetLabel: UILabel!


    var viewModel: MDListCellViewModel?

    override func prepareForReuse() {
        super.prepareForReuse()

        viewModel = nil
        iconImageView.image = nil
        titleLabel.text = nil
        usedLabel.text = nil
        budgetLabel.text = nil
    }

    func setProperties(num: Int, category: String, budget: Int) {
        iconImageView.image = UIImage(named: "ic\(num + 1)")
        titleLabel.text = category
        usedLabel.text = "30,000"
        budgetLabel.text = "\(budget)"
    }
}

extension MDListTableViewCell: MDCellBindableType {
    func bindViewModel() {
        guard let viewModel = viewModel else { return }

    }
}
