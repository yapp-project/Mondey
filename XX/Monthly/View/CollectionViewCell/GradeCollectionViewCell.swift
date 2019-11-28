//
//  GradeCollectionViewCell.swift
//  XX
//
//  Created by 이재은 on 26/11/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import UIKit

class GradeCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier = "GradeCollectionViewCell"

    @IBOutlet weak var gradeImageView: UIImageView!
    @IBOutlet weak var monthLabel: UILabel!

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

    func setProperties(_ data: [Int: String]) {
        gradeImageView.image = UIImage(named: "gradeA")
        monthLabel.text = "3월"
    }
}

//guard let viewModel = viewModel else { return }
//signInButton.rx.action = viewModel.presentSignInAction()
//singUpButton.rx.action = viewModel.presentSignUpAction()
//
//emailTextField.rx.text.orEmpty
//    .bind(to: viewModel.emailTextRelay)
//    .disposed(by: rx.disposeBag)
//passwordTextField.rx.text.orEmpty
//    .bind(to: viewModel.passwordTextRelauy)
//    .disposed(by: rx.disposeBag)
