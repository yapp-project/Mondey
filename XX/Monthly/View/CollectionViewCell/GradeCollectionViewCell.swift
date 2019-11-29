//
//  GradeCollectionViewCell.swift
//  XX
//
//  Created by 이재은 on 26/11/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import UIKit

class GradeCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier = "gradeCollectionViewCell"

    @IBOutlet weak var gradeImageView: UIImageView!
    @IBOutlet private weak var monthLabel: UILabel!

    var viewModel: GradeCellViewModel?

    override func prepareForReuse() {
        super.prepareForReuse()

        viewModel = nil
        gradeImageView.image = nil
        monthLabel.text = nil
    }
}

extension GradeCollectionViewCell: GradeCellBindableType {
    func bindViewModel() {
        guard let viewModel = viewModel else { return }

    }

    func setProperties(month: Int, grade: String) {
        gradeImageView.image = UIImage(named: "grade\(grade)")
        monthLabel.text = "\(month+1)월"
    }
}
