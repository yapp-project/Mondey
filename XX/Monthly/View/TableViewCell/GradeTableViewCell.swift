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

    let gradeData = [1: "A", 1: "A", 1: "C", 1: "A", 1: "A",
                     1: "A", 1: "A", 1: "B", 1: "A", 1: "A"]

    override func awakeFromNib() {
        super.awakeFromNib()

        gradeCollectionView.dataSource = self
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
            .dequeueReusableCell(withReuseIdentifier: "gradeCollectionViewCell",
                                 for: indexPath) as? GradeCollectionViewCell
            else { return UICollectionViewCell() }

        cell.setProperties(gradeData)

        return cell
    }

}
