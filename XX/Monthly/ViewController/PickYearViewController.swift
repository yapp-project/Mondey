//
//  PickYearViewController.swift
//  XX
//
//  Created by 이재은 on 19/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import UIKit

class PickYearViewController: BaseViewController {

    @IBOutlet weak var yearTableView: UITableView!
    @IBOutlet weak var closeButton: UIButton!

    var viewModel: PickYearViewModel?

    var year = [0: ["Year": "2019"], 1: ["Year": "2018"], 2: ["Year": "2017"]]


    override func viewDidLoad() {
        super.viewDidLoad()

        self.yearTableView.rowHeight = 80

        setTableView()
    }

    private func setTableView() {
        let cellType = Observable.of(year)

        cellType.bind(to: yearTableView.rx.items(cellIdentifier: "yearCell", cellType: YearTableViewCell.self)) { (row, element, cell) in
            cell.backgroundColor = UIColor.clear
            cell.yearLabel.text = "4844"
            }.disposed(by: rx.disposeBag)
    }

}

extension PickYearViewController: ViewModelBindableType {

    func bindViewModel() {
        guard let viewModel = viewModel else { return }
        closeButton.rx.action = viewModel.requestCloseButtonAction()
    }
}
