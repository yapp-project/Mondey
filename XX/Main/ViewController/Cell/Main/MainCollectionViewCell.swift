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
    
    @IBOutlet weak var mainCellDivision: UILabel!
    @IBOutlet weak var mainCellCategoryLabel: UILabel!
    @IBOutlet weak var mainCellUseMoneyLabel: UILabel!
    @IBOutlet weak var mainCellAllMoneyLabel: UILabel!
    
    @IBOutlet weak var mainCellPercentNumLabel: UILabel!
    @IBOutlet weak var mainCellPercentBarWidth: NSLayoutConstraint!
    
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
        removeCellButton.rx.action = viewModel.requestMainCellRemoveModeButtonAction(cellIdx: cellIdx ?? 0,
                                                                                 button: &removeCellButton)
        
   
        
        
        viewModel.category
            .map { "\(String(describing: $0.period))" }
            .bind(to: mainCellDivision.rx.text )
            .disposed(by: viewModel.rx.disposeBag)
        
        viewModel.category
            .map { $0.title }
            .bind(to: mainCellCategoryLabel.rx.text )
            .disposed(by: viewModel.rx.disposeBag)
        
        viewModel.category
            .map { "\($0.budget)" }
            .bind(to: mainCellUseMoneyLabel.rx.text )
            .disposed(by: viewModel.rx.disposeBag)
    }
}
