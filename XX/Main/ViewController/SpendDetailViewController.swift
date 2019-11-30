//
//  SpendDetailViewController.swift
//  XX
//
//  Created by 박은비 on 19/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import UIKit

class SpendDetailViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView! 
    
    let SPEND_DETAIL_HEADER_CELL = "SpendDetailHeaderReusableView"
    
    var viewModel: SpendDetailViewModel?
    let bag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        bindCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

extension SpendDetailViewController: ViewModelBindableType {
    func bindViewModel() {
        guard let viewModel = viewModel else { return }
        print("viewModel \(viewModel.spendDetailCategory.value)")
//        backButton.rx.action = viewModel.requestBackButtonAction()
    }
    
    private func bindCollectionView() {
        let dummyData =  ["default",
                          "London",
                          "Vienna",
                          "Lisbon",
                          "Lisbon",
                          "Lisbon",
                          "Lisbon",
                          "Lisbon",
                          "Lisbon",
                          "Lisbon"]
        
        //뷰모델을 전달하면..?
        let sections = [
            SectionModel<String, String>(model: "Fisrt", items: dummyData)
        ]
        
        Observable.just(sections)
            .bind(to: collectionView.rx.items(dataSource: spendDetailDatasource))
            .disposed(by: bag)
    }
    
    typealias CollectionModel = SectionModel<String, String>
    typealias CollectionViewDataSource = RxCollectionViewSectionedReloadDataSource<CollectionModel>
    
    private var spendDetailDatasource: CollectionViewDataSource {
        let configureCell: (CollectionViewSectionedDataSource<CollectionModel>, UICollectionView, IndexPath, String) -> UICollectionViewCell =
        { (datasource,
            collectionView,
            indexPath,
            element) in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SpendDetailCell", for: indexPath) as? SpendDetailCell
                else { return UICollectionViewCell() }
            
            return cell
            
//            return UICollectionViewCell()
        }
        
        let datasource = CollectionViewDataSource.init(configureCell: configureCell)
        
        datasource.configureSupplementaryView = {
            (dataSource,
            collectionView,
            kind,
            indexPath) -> UICollectionReusableView in
            if let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: self.SPEND_DETAIL_HEADER_CELL, for: indexPath) as? SpendDetailHeaderReusableView {

                // 어떻게 하면 더 나은 방법으로 전달할수 있을가
                //                header.addSpendMoveButton.rx.action = self.viewModel?.requestAddSpendMoveMoveAction()

                header.viewModel = self.viewModel
                return header
            }

            return UICollectionReusableView()
        }
        
        return datasource
        
    }
    
}

