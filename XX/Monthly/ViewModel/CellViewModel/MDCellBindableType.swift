//
//  MDCellBindableType.swift
//  XX
//
//  Created by 이재은 on 24/11/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import Foundation

protocol MDCellBindableType {
    associatedtype viewModelType

    var viewModel: viewModelType? { get set }

    func bindViewModel()
}

extension MDCellBindableType where Self: UITableViewCell {
    mutating func bind(viewModel: Self.viewModelType) {
        self.viewModel = viewModel

        bindViewModel()
    }
}
