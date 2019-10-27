//
//  MainHeaderReusableView.swift
//  XX
//
//  Created by 박은비 on 27/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import UIKit
import CenteredCollectionView


class MainHeaderReusableView: UICollectionReusableView {
    
    let cellPercentWidth: CGFloat = 0.83
    
    let cellPercentWidth2: CGFloat = 0.037
    var centeredCollectionViewFlowLayout: CenteredCollectionViewFlowLayout!

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        centeredCollectionViewFlowLayout = (collectionView.collectionViewLayout as! CenteredCollectionViewFlowLayout)
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        
        self.applyGradient()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        centeredCollectionViewFlowLayout.itemSize = CGSize(
            width: UIScreen.main.bounds.width * cellPercentWidth,
            height: 158 // fix value
        )
        
        centeredCollectionViewFlowLayout.minimumLineSpacing = UIScreen.main.bounds.width * cellPercentWidth2
        

    }
}

extension MainHeaderReusableView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected Cell #\(indexPath.row)")
    }
}

extension MainHeaderReusableView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: "CollectionViewCell"), for: indexPath) as! MainViewCollectionViewCell
        cell.label.text = "Cell #\(indexPath.row)"
        
        cell.contentView.layer.cornerRadius = 15.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowOffset = CGSize(width: 1, height: 4.0)
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOpacity = 10.0
        
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds,
                                             cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("Current centered index: \(String(describing: centeredCollectionViewFlowLayout.currentCenteredPage ?? nil))")
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        print("Current centered index: \(String(describing: centeredCollectionViewFlowLayout.currentCenteredPage ?? nil))")
    }
}

extension UIView {
    func applyGradient() {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.locations = [0, 1]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.colors = [
            UIColor.peach.cgColor,
            UIColor.orange.cgColor
        ]
        layer.insertSublayer(gradient, at: 0)
    }
}


extension UIColor {
    static var peach: UIColor {
        return  UIColor(red: 1, green: 0.5764705882, blue: 0.5843137255, alpha: 1)
    }
    
    static var orange: UIColor {
        return UIColor(red: 1, green: 0.5764705882, blue: 0.462745098, alpha: 1)
    }
}
