//
//  MainCollectionViewCell.swift
//  XX
//
//  Created by 박은비 on 31/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var percentBarView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        percentBarView.setCorner(cornerRadius: (self.contentView.bounds.width * 0.078 / 2) )
    }
}
