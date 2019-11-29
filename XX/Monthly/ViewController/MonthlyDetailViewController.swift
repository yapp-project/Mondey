//
//  MonthlyDetailViewController.swift
//  XX
//
//  Created by 이재은 on 19/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import UIKit

class MonthlyDetailViewController: BaseViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var monthLabel: UILabel!
    @IBOutlet private weak var gradeImageView: UIImageView!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var leftButton: UIButton!
    @IBOutlet private weak var rightButton: UIButton!
    @IBOutlet private weak var usedLabel: UILabel!
    @IBOutlet private weak var budgetLabel: UILabel!

    var viewModel: MonthlyDetailViewModel?
    var month: Int?
    var grade: String?
    let gradeData = ["A", "A", "C", "A", "C", "B",
                     "D", "B", "A", "A", "B", "Q"]

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "월 소비 평가"
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        setLabel()
    }

    @IBAction func showPreviousMonth(_ sender: Any) {
        if var num = month {
            if num >= 2 {
                num -= 1
                month = num
                monthLabel.text = "\(num)월"
                gradeImageView.image = UIImage(named: "grade\(gradeData[num - 1])")
                priceLabel.text = "30,000원"
                usedLabel.text = "10,000"
                budgetLabel.text = "/ 300,000"
                tableView.reloadData()
            }
            if num == 1 {
                leftButton.isHidden = true
            } else {
                leftButton.isHidden = false
                rightButton.isHidden = false
            }
        }
    }

    @IBAction func showNextMonth(_ sender: Any) {
        if var num = month {
            if num <= 10 {
                num += 1
                month = num
                monthLabel.text = "\(num)월"
                gradeImageView.image = UIImage(named: "grade\(gradeData[num - 1])")
                priceLabel.text = "30,000원"
                usedLabel.text = "10,000"
                budgetLabel.text = "/ 300,000"
                tableView.reloadData()
            }
            if num == 11 {
                rightButton.isHidden = true
            } else {
                leftButton.isHidden = false
                rightButton.isHidden = false
            }
        }
    }

    func setLabel() {
        monthLabel.text = "\(month ?? 1)월"
        gradeImageView.image = UIImage(named: "grade\(grade ?? "Q")")
        priceLabel.text = "30,000원"
        usedLabel.text = "10,000"
        budgetLabel.text = "/ 300,000"
    }

}

extension MonthlyDetailViewController: ViewModelBindableType {
    
    func bindViewModel() {
        guard let viewModel = viewModel else { return }

        leftButton.rx.action = viewModel.showPreviousMonthAction()
        rightButton.rx.action = viewModel.showNextMonthAction()
    }
}

extension MonthlyDetailViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let listCell = tableView
            .dequeueReusableCell(withIdentifier: "MDListTableViewCell",
                                 for: indexPath) as? MDListTableViewCell
            else { return UITableViewCell() }

        return listCell

    }
}

extension MonthlyDetailViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 86
    }
}
