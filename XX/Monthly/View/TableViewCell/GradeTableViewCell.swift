//
//  GradeTableViewCell.swift
//  XX
//
//  Created by 이재은 on 26/11/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import UIKit

protocol GradeCellDelegate: class {
    func moveMonthlyDetailView(month: Int, grade: String)
    func movePickYearView()
}

class GradeTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var yearButton: UIButton!
    @IBOutlet private weak var gradeCollectionView: UICollectionView!

    let gradeData = ["A", "A", "C", "A", "C", "B",
                     "D", "B", "A", "A", "B", "Q"]
    var viewModel: MonthlyViewModel?
    weak var delegate: GradeCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()

        gradeCollectionView.dataSource = self
        gradeCollectionView.delegate = self

        bindViewModel()
    }
    
    @IBAction func presentPickYear(_ sender: Any) {
        delegate?.movePickYearView()
    }

}

extension GradeTableViewCell: ViewModelBindableType {
    
    func bindViewModel() {
        guard let viewModel = viewModel else { return }
        //        yearButton.rx.action = viewModel.presentingSelectYear()
        gradeCollectionView.rx.itemSelected.bind { (IndexPath) in
            viewModel.presentingDetail().execute()
            }.disposed(by: rx.disposeBag)
    }
}


extension GradeTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return gradeData.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "GradeCollectionViewCell", for: indexPath) as? GradeCollectionViewCell
            else { return UICollectionViewCell() }

        let grade = gradeData[indexPath.row]
        cell.setProperties(month: indexPath.item, grade: grade)

        return cell
    }
    
}

// MARK: - UICollectionViewDelegate

extension GradeTableViewCell: UICollectionViewDelegate {

        func collectionView(_ collectionView: UICollectionView,
                            didSelectItemAt indexPath: IndexPath) {

    //        guard let gradeCell = collectionView
    //            .cellForItem(at: indexPath) as? GradeCollectionViewCell
    //            else { return }
            delegate?.moveMonthlyDetailView(month: indexPath.item + 1, grade: gradeData[indexPath.item])
        }
}
