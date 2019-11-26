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
    
    var category = BehaviorRelay<Category>(value: .init())
    var filterCateogryAllValue = BehaviorRelay<Int>(value: .init())
    
    let PERCENT_BAR_BASE_WIDTH = UIScreen.main.bounds.width * 0.405 * 0.53
    
    @IBOutlet weak var percentBarView: UIView!
    @IBOutlet weak var percentRealBarView: UIView!
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
    
    func setPercentBar() {
        DispatchQueue.main.async { [unowned self] in
            
            let percent: Double = Double(self.filterCateogryAllValue.value) / Double(self.category.value.budget)
            
//            print("왜 ㅠㅠ\(self.filterCateogryAllValue.value) \(self.category.value.budget) \(percent) ")
            
            let percentResult = Int(floor(percent * 100))
            self.mainCellPercentNumLabel.text = "\(100 < percentResult ? 100 : percentResult)%"
            
            self.mainCellPercentBarWidth.constant = (self.PERCENT_BAR_BASE_WIDTH * CGFloat(percent))
        }
    }
}

extension MainCollectionViewCell: ViewModelBindableType {
    func bindViewModel() {
        guard let viewModel = viewModel else { return }
        removeCellButton.rx.action = viewModel.requestMainCellRemoveModeButtonAction(cellIdx: cellIdx ?? 0,
                                                                                     button: &removeCellButton)
        
        category.subscribe { [unowned self] value in
            DispatchQueue.main.async{
                self.mainCellCategoryLabel.text = value.element?.title
                //                self.mainCellUseMoneyLabel.text = self.category.map{"\($0.budget)"}
                self.mainCellAllMoneyLabel.text = "/\(value.element?.budget ?? 0)"
                
                self.percentRealBarView.backgroundColor = value.element?.tintColor
                self.mainCellPercentNumLabel.textColor = value.element?.tintColor
                
            }}
            .disposed(by: rx.disposeBag)
        
        filterCateogryAllValue.subscribe{ [unowned self] value in
            DispatchQueue.main.async {
                self.mainCellUseMoneyLabel.text = "\(value.element ?? 0)"
                
                self.setPercentBar()
            } }.disposed(by: rx.disposeBag)
    }
}
