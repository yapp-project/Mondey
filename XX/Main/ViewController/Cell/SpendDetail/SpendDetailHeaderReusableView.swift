//
//  SpendDetailHeaderReusableView.swift
//  XX
//
//  Created by 박은비 on 02/11/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import UIKit

class SpendDetailHeaderReusableView: UICollectionReusableView {
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var infoView: UIView!
    
    @IBOutlet weak var percentBar: UIView!
    @IBOutlet weak var percentNumLabel: UILabel!
    @IBOutlet weak var percentRealBarView: UIView!
    @IBOutlet weak var percentBarWidth: NSLayoutConstraint!
    
    @IBOutlet weak var topHeaderImageView: UIImageView!
    
    @IBOutlet weak var detailTitleLabel: UILabel!
    @IBOutlet weak var detailUseMoneyLabel: UILabel!
    @IBOutlet weak var detailAllMoneyLabel: UILabel!
    
    let PERCENT_BAR_BASE_WIDTH = UIScreen.main.bounds.width * 0.544
    
    
    var viewModel: SpendDetailViewModel? {
        didSet{
            bindViewModel()
        }
    } 
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        percentBar.layer.cornerRadius = 6.0
//        infoView.layer.borderColor = UIColor.clear.cgColor
        percentBar.layer.masksToBounds = true
        
        infoView.layer.shadowColor = UIColor.lightGray.cgColor.copy(alpha: 0.5)
        infoView.layer.shadowOffset = CGSize(width: 1, height: 1)
        infoView.layer.shadowOpacity = 5
        infoView.layer.masksToBounds = false
        
        
        bindViewModel()
    }
}


extension SpendDetailHeaderReusableView: ViewModelBindableType {
    func bindViewModel() {
        guard let viewModel = viewModel else { return }
        backButton.rx.action = viewModel.requestBackButtonAction()
        
        viewModel.spendDetailCategory.subscribe{ [unowned self] (value) in
            self.detailTitleLabel.text = value.element?.title

            let categoryUsePrice = MemoryStorage.shared.expenditures.filter{ $0.id == value.element?.id }.map{$0.cost}.reduce(0, {$0 + $1})
            
            self.detailUseMoneyLabel.text = "\(categoryUsePrice)"
            self.detailAllMoneyLabel.text = "/ \(value.element?.budget ?? 0)"
            
            let doubleUseMoney = Double(self.detailUseMoneyLabel.text ?? "0")
            let detailAllMoney = Double(self.detailAllMoneyLabel.text ?? "0")
            
            self.setPercentBar(usePrice: doubleUseMoney ?? 1,
                               allPrice: detailAllMoney ?? 1)
            
            //image
            
            self.percentRealBarView.backgroundColor = value.element?.catTintColor
            self.percentNumLabel.textColor = value.element?.catTintColor
            
            
            DispatchQueue.main.async { [unowned self] in
                self.topHeaderImageView.image = UIImage.init(named: "category\(value.element?.id ?? 1)")
            }
            
            
        }.disposed(by: rx.disposeBag)
    }
    
    func setPercentBar(usePrice: Double,
                       allPrice: Double) {
        DispatchQueue.main.async { [unowned self] in
            
            let percent: Double = usePrice / allPrice
            
            let percentResult = Int(floor(percent * 100))
            self.percentNumLabel.text = "\(100 < percentResult ? 100 : percentResult)%"
            
            self.percentBarWidth.constant = (self.PERCENT_BAR_BASE_WIDTH * CGFloat(percent))
        }
    }
}
