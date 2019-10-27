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
    let cellPercntSpacing: CGFloat = 0.037
    
    var centeredCollectionViewFlowLayout: CenteredCollectionViewFlowLayout!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // 뷰모델 너무 많아질것을 고려하여 MainViewModel 갖다씀
    var viewModel: MainViewModel?
    let bag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setLayoutCollectionView()
        bindCollectionView()
    }
    
    func setLayoutCollectionView() {
        centeredCollectionViewFlowLayout = (collectionView.collectionViewLayout as! CenteredCollectionViewFlowLayout)
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        
        centeredCollectionViewFlowLayout.itemSize = CGSize(
            width: UIScreen.main.bounds.width * cellPercentWidth,
            height: 158 // fix value
        )
        
        centeredCollectionViewFlowLayout.minimumLineSpacing = UIScreen.main.bounds.width * cellPercntSpacing
    }
}


extension MainHeaderReusableView: ViewModelBindableType {
    func bindViewModel() {
//        guard let viewModel = viewModel else { return }
    }
    
    private func bindCollectionView() {
        let dummyData = ["page - 1", "page - 2"]
        
        let sections = [
            SectionModel<String, String>(model: "first section", items: dummyData)
        ]
         
        collectionView
            .rx.didEndDecelerating
            .bind { () in
//                print("Current centered index: \(String(describing: self.centeredCollectionViewFlowLayout.currentCenteredPage ?? nil))")
            }.disposed(by: bag)
        
        collectionView
            .rx.didEndScrollingAnimation
            .bind { () in
//              print("Current centered index: \(String(describing: self.centeredCollectionViewFlowLayout.currentCenteredPage ?? nil))")
        }.disposed(by: bag)
        
        collectionView
            .rx.itemSelected.bind { (indexPath) in
//                print("indexPath >>> \(indexPath.item)")
        }.disposed(by: bag)
        
        Observable.just(sections)
            .bind(to: collectionView.rx.items(dataSource: mainDatasource))
            .disposed(by: bag)
    }
    
    typealias MainHeaderReusableSectionModel = SectionModel<String, String>
    typealias MainHeaderCollectionViewDataSource = RxCollectionViewSectionedReloadDataSource<MainHeaderReusableSectionModel>
    
    private var mainDatasource: MainHeaderCollectionViewDataSource {
        let configureCell: (CollectionViewSectionedDataSource<MainHeaderReusableSectionModel>, UICollectionView, IndexPath, String) -> UICollectionViewCell =
        { (datasource, collectionView, indexPath,  element) in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: "CollectionViewCell"), for: indexPath) as! MainViewCollectionViewCell
            cell.label.text = "Cell #\(element)"
            
            cell.contentView.layer.cornerRadius = 15.0
            cell.contentView.layer.borderWidth = 1.0
            cell.contentView.layer.borderColor = UIColor.clear.cgColor
            cell.contentView.layer.masksToBounds = true
            cell.layer.shadowColor = UIColor.lightGray.cgColor.copy(alpha: 0.3)
            cell.layer.shadowOffset = CGSize(width: -3.0, height: 2.0)
            cell.layer.shadowRadius = 4.0
            cell.layer.shadowOpacity = 10
            
            cell.layer.masksToBounds = false
            cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds,
                                                 cornerRadius: cell.contentView.layer.cornerRadius).cgPath
            
            return cell
        }
        
        let datasource = MainHeaderCollectionViewDataSource.init(configureCell: configureCell)
        
        return datasource
    }
}

