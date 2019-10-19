//
//  MonthlyViewController.swift
//  XX
//
//  Created by 이재은 on 06/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import UIKit

class MonthlyViewController: BaseViewController {

    @IBOutlet weak var yearButton: UIButton!
    @IBOutlet weak var gradeCollectionView: UICollectionView!
    @IBOutlet weak var percentView: UIView!
    @IBOutlet weak var rankingTableView: UITableView!

    var viewModel: MonthlyViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}

extension MonthlyViewController: ViewModelBindableType {

    func bindViewModel() {
        guard let viewModel = viewModel else { return }
        yearButton.rx.action = viewModel.presentingSelectYear()
    }
}
