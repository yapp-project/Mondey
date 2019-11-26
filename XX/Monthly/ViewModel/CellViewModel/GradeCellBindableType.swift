//
//  GradeCellBindableType.swift
//  XX
//
//  Created by 이재은 on 26/11/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import Foundation

protocol GradeCellBindableType {
    associatedtype viewModelType

    var viewModel: viewModelType? { get set }

    func bindViewModel()
}

extension GradeCellBindableType where Self: UICollectionViewCell {
    mutating func bind(viewModel: Self.viewModelType) {
        self.viewModel = viewModel

        bindViewModel()
    }
}
