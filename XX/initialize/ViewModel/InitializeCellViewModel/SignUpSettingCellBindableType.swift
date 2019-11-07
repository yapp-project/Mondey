//
//  InitializeCellBindableType.swift
//  XX
//
//  Created by Seonghun Kim on 2019/11/02.
//  Copyright © 2019 YAPP. All rights reserved.
//

import Foundation

protocol SignUpSettingCellBindableType {
    associatedtype ViewModelType
    
    var viewModel: ViewModelType? { get set }
    
    func bindViewModel()
}

extension SignUpSettingCellBindableType where Self: UITableViewCell {
    mutating func bind(viewModel: Self.ViewModelType) {
        self.viewModel = viewModel

        bindViewModel()
    }
}
