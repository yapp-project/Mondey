//
//  UICollectionViewCell+.swift
//  XX
//
//  Created by 박은비 on 31/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
    open override func awakeFromNib() {
        super.awakeFromNib()
        // 나중에 하기 기능 함수화 하기 급해서..일단 영차영차함
        if self.isKind(of: MainHeaderCollectionViewFirstCell.self) ||
            self.isKind(of: MainHeaderCollectionViewSecondCell.self) {
            // 하기에서 메모리 낭비가 있을것 같음. 나중에 방안 찾아보도록 하자
            
            // 대충 체크용..
            if self.layer.shadowColor != UIColor.lightGray.cgColor.copy(alpha: 0.5) {
                self.contentView.layer.cornerRadius = 15.0
                self.contentView.layer.borderWidth = 1.0
                self.contentView.layer.borderColor = UIColor.clear.cgColor
                self.contentView.layer.masksToBounds = true
                self.contentView.backgroundColor = UIColor.white
                self.layer.shadowColor = UIColor.lightGray.cgColor.copy(alpha: 0.3)
                self.layer.shadowOffset = CGSize(width: 1, height: 1)
                self.layer.shadowRadius = 4.0
                self.layer.shadowOpacity = 5
                
                
                self.layer.masksToBounds = false
                print(self.bounds)
                self.layer.shadowPath = UIBezierPath(roundedRect: CGRect(x: 0,
                                                                         y: 0,
                                                                         width: UIScreen.main.bounds.width * 0.845,
                                                                         height: 158),
                                                     cornerRadius: self.contentView.layer.cornerRadius).cgPath
            }
        }
        else if self.isKind(of: MainCollectionViewCell.self ) {
            
            if self.layer.shadowColor != UIColor.lightGray.cgColor.copy(alpha: 0.5) {
                self.contentView.layer.cornerRadius = 10.0
                self.contentView.layer.borderWidth = 1.0
                self.contentView.layer.borderColor = UIColor.clear.cgColor
                self.contentView.layer.masksToBounds = true
                self.contentView.backgroundColor = UIColor.white
                self.layer.shadowColor = UIColor.lightGray.cgColor.copy(alpha: 0.5)
                self.layer.shadowOffset = CGSize(width: 1, height: 1)
                self.layer.shadowRadius = 4.0
                self.layer.shadowOpacity = 5
                
                
                self.layer.masksToBounds = false
                print(self.bounds)
                self.layer.shadowPath = UIBezierPath(roundedRect: CGRect(x: 0,
                                                                         y: 0,
                                                                         width: UIScreen.main.bounds.width * 0.403,
                                                                         height: UIScreen.main.bounds.width * 0.403),
                                                     cornerRadius: self.contentView.layer.cornerRadius).cgPath
            }
            

        }
        
    }
}
