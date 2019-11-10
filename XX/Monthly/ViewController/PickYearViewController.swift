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

    var year = [0: "2019"]//, 1: "2018", 2: "2017"]


    override func viewDidLoad() {
        super.viewDidLoad()

        self.yearTableView.rowHeight = 50

        setTableView()
    }

    private func setTableView() {
        let cellType = Observable.of(year)

        cellType.bind(to: yearTableView.rx.items(cellIdentifier: "yearCell", cellType: YearTableViewCell.self)) { (row, element, cell) in
            cell.yearLabel.text = "\(element.value)년"
            //            cell.checkImageView.image = UIImage(named: "")
        }.disposed(by: rx.disposeBag)
    }

}

extension PickYearViewController: ViewModelBindableType {

    func bindViewModel() {
        guard let viewModel = viewModel else { return }
        closeButton.rx.action = viewModel.requestCloseButtonAction()

//        yearTableView.rx.itemSelected
//            .map { $0.row }
//            .subscribe(viewModel.selectItem)
//            .disposed(by: rx.disposeBag)
    }
}
