//
//  MonthlyDetailViewController.swift
//  XX
//
//  Created by 이재은 on 19/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import Foundation

class MonthlyDetailViewController: BaseViewController {
    
    var viewModel: MonthlyDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

extension MonthlyDetailViewController: ViewModelBindableType {
    
    func bindViewModel() {
        guard let viewModel = viewModel else { return }
        
    }
}


