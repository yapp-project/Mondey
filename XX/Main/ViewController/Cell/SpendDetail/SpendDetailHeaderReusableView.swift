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
    
    var viewModel: SpendDetailViewModel? {
        didSet{
            bindViewModel()
        }
    } 
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        infoView.layer.cornerRadius = 10.0
//        infoView.layer.borderWidth = 1.0
//        infoView.layer.borderColor = UIColor.clear.cgColor
//        infoView.layer.masksToBounds = true
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
    }
    
}
