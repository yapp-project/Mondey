//
//  MainViewCollectionViewCell.swift
//  XX
//
//  Created by 박은비 on 27/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import UIKit

class MainViewCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var viewWidth: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        view.backgroundColor = UIColor.red
//        view.layer.shadowColor = UIColor.black.cgColor // 검정색 사용
//        view.layer.masksToBounds = false
//        view.layer.shadowOffset = CGSize(width: 0, height: 4) // 반경에 대해서 너무 적용이 되어서 4point 정도 ㅐ림.
//        view.layer.shadowRadius = 5 // 반경?
//        view.layer.shadowOpacity = 0.2 // alpha값입니다.
//        
//        viewWidth.constant = UIScreen.main.bounds.width * 0.83
        
//        myView.layer.shouldRasterize = true
     
    }
}
