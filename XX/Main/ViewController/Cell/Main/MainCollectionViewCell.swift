//
//  MainCollectionViewCell.swift
//  XX
//
//  Created by 박은비 on 31/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    var cellIdx: Int? = nil
    
    @IBOutlet weak var percentBarView: UIView!
    @IBOutlet weak var removeCellButton: UIButton!
    
    var viewModel: MainViewModel? = nil{
        didSet{
            bindViewModel()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        percentBarView.setCorner(cornerRadius: (self.contentView.bounds.width * 0.078 / 2) )
    }
}

extension MainCollectionViewCell: ViewModelBindableType {
    func bindViewModel() {
        guard let viewModel = viewModel else { return }
        removeCellButton.rx.action = viewModel.requestMainRemoveModeButtonAction(cellIdx: cellIdx ?? 0,
                                                                                 button: &removeCellButton)
    }
}
