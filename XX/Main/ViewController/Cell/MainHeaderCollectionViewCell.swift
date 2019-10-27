//
//  MainHeaderCollectionViewCell.swift
//  XX
//
//  Created by 박은비 on 27/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import UIKit

class MainHeaderCollectionViewFirstCell: UICollectionViewCell {
    @IBOutlet weak var backView: UIView!
    
}

class MainHeaderCollectionViewSecondCell: UICollectionViewCell {
    @IBOutlet weak var textLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        print("호출은되니")
    }
}

