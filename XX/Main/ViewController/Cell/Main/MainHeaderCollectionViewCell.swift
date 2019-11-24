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
    @IBOutlet weak var okButton: UIButton!
    
    var viewModel: MainViewModel? = nil{
        didSet{
            bindViewModel()
        }
    }
}

extension MainHeaderCollectionViewFirstCell: ViewModelBindableType {
    func bindViewModel() {
        guard let viewModel = viewModel else { return }
        
        okButton.rx.action = viewModel.requestMainHeaderCellOkAction()
    }
}
    

class MainHeaderCollectionViewSecondCell: UICollectionViewCell {
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var rightView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setLayout()
    }
    
    func setLayout() {
        self.rightView.setCorner(cornerRadius: 20)
    }
}

