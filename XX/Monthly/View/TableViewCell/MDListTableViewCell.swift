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

    let price = [30000, 20000, 50500, 23000, 60000, 10000, 3000, 10300, 70000, 30000, 20200]
    func setProperties(num: Int, category: String, budget: Int) {
        let randNum = arc4random_uniform(10)
        iconImageView.image = UIImage(named: "ic\(num + 1)")
        titleLabel.text = category
        usedLabel.text = "\(price[Int(randNum)])원"
        budgetLabel.text = "/ \(budget) 원"
    }
}

extension MDListTableViewCell: MDCellBindableType {
    func bindViewModel() {
        guard let viewModel = viewModel else { return }

    }
}
