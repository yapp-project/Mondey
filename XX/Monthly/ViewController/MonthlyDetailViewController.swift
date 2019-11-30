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
    let gradeData = ["DotAA", "DotAA", "C", "DotAA", "C", "DotB",
                     "D", "DotB", "DotAA", "DotAA", "DotB", "Q"]
    let categoriesBudget = [500000, 200000, 150000,
                      100000, 50000, 50000, 70000]

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "월 소비 평가"
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        setLabel()
        if month == 1 {
            leftButton.isHidden = true
        }
        if month == 11 {
            rightButton.isHidden = true
        }
    }

    @IBAction func showPreviousMonth(_ sender: Any) {
        if var num = month {
            if num >= 2 {
                num -= 1
                month = num
                monthLabel.text = "\(num)월"
                gradeImageView.image = UIImage(named: "grade\(gradeData[num - 1])")
                setMoneyLabel(month: num)
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
                setMoneyLabel(month: num)
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

    private func setLabel() {
        if let num = month {
            monthLabel.text = "\(num)월"
            gradeImageView.image = UIImage(named: "grade\(gradeData[num - 1])")
            setMoneyLabel(month: num)
        }
    }

    private func calculateMount(month: Int) -> [Int] {
        let budget = TempData.monthHistory[month]?.budget ?? 0
        let mount = TempData.monthHistory[month]?.mount ?? 0

        let result = mount - budget
        if result < 0 {
            return [0, mount, budget]
        } else {
            return [result, mount, budget]
        }
    }

    private func setMoneyLabel(month: Int) {
        let result = calculateMount(month: month)
        priceLabel.text = "\(result[0])원"
        usedLabel.text = "\(result[1])"
        budgetLabel.text = "/ \(result[2])"
    }

}

extension MonthlyDetailViewController: ViewModelBindableType {
    
    func bindViewModel() {
//        guard let viewModel = viewModel else { return }
//
//        leftButton.rx.action = viewModel.showPreviousMonthAction()
//        rightButton.rx.action = viewModel.showNextMonthAction()
    }
}

extension MonthlyDetailViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MondeyHelper.mondeyCategoryTitle.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let listCell = tableView
            .dequeueReusableCell(withIdentifier: "MDListTableViewCell",
                                 for: indexPath) as? MDListTableViewCell
            else { return UITableViewCell() }

        let title = MondeyHelper.mondeyCategoryTitle[indexPath.row]
        let budget = categoriesBudget[indexPath.row]
        
        listCell.setProperties(num: indexPath.row,
                               category: title,
                               budget: budget)
        
        return listCell

    }
}

extension MonthlyDetailViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 86
    }
}
