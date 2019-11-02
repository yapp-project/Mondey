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
    let FIRST_CELL_NAME = "MainHeaderCollectionViewFirstCell"
    let SECOND_CELL_NAME = "MainHeaderCollectionViewSecondCell"
    
    let cellPercentWidth: CGFloat = 0.845
    let cellPercntSpacing: CGFloat = 0.037
    
    var centeredCollectionViewFlowLayout: CenteredCollectionViewFlowLayout!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var addSpendMoveButton: UIButton!
    
    // 뷰모델 너무 많아질것을 고려하여 MainViewModel 갖다놓긴 했는데 어디서 이 뷰모델 값을 세팅해야할진 아직 고민 안해봄 ㅎㅎ!
    var viewModel: MainViewModel?
    let bag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setLayoutCollectionView()
        bindViewModel()
        bindCollectionView()
    }
    
    func setLayoutCollectionView() {
        let nib = UINib(nibName: FIRST_CELL_NAME, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: FIRST_CELL_NAME)
        
        let nib2 = UINib(nibName: SECOND_CELL_NAME, bundle: nil)
        collectionView.register(nib2, forCellWithReuseIdentifier: SECOND_CELL_NAME)
        
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
//        addSpendMoveButton.rx.action = viewModel.requestAddSpendMoveMoveAction()
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
            
            if indexPath.item == 0 {
                guard let cell = collectionView
                    .dequeueReusableCell(withReuseIdentifier: self.FIRST_CELL_NAME,
                                         for: indexPath) as? MainHeaderCollectionViewFirstCell
                    else {
                        return UICollectionViewCell()
                }
                
                return cell
                
            } else {
                guard let cell = collectionView
                    .dequeueReusableCell(withReuseIdentifier: self.SECOND_CELL_NAME,
                                         for: indexPath) as? MainHeaderCollectionViewSecondCell
                    else {
                        return UICollectionViewCell()
                }
                
                return cell
            }
        }
        
        let datasource = MainHeaderCollectionViewDataSource.init(configureCell: configureCell)
        
        return datasource
    }
}

