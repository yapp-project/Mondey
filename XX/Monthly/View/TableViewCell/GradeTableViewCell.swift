//
//  GradeTableViewCell.swift
//  XX
//
//  Created by 이재은 on 26/11/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import UIKit

class GradeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var yearButton: UIButton!
    @IBOutlet weak var gradeCollectionView: UICollectionView!

    let gradeData = ["B", "A", "C", "A", "C",
                     "B", "D", "B", "A", "A"]
    var viewModel: MonthlyViewModel?

    override func awakeFromNib() {
        super.awakeFromNib()

        gradeCollectionView.dataSource = self
        bindViewModel()
    }
    
    
}

extension GradeTableViewCell: ViewModelBindableType {
    
    func bindViewModel() {
        guard let viewModel = viewModel else { return }
        yearButton.rx.action = viewModel.presentingSelectYear()
    }
}

extension GradeTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "GradeCollectionViewCell",
                                 for: indexPath) as? GradeCollectionViewCell
            else { return UICollectionViewCell() }

        let grade = gradeData[indexPath.row]
        cell.setProperties(month: indexPath.row, grade: grade)
        
        return cell
    }
    
}
