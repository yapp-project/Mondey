//
//  MainViewController.swift
//  XX
//
//  Created by 박은비 on 19/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController {

    @IBOutlet weak var spendDetailMoveButton: UIButton!
    @IBOutlet weak var addSpendMoveButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let HEADER_CELL_NAME = "MainHeaderCell"
    let SUB_HEADER_CELL_NAME = "MainSubHeaderCell"
    let MAIN_CELL_NAME = "MainCollectionViewCell"
    
    var viewModel: MainViewModel?
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

extension MainViewController: ViewModelBindableType {
    func bindViewModel() {
        guard let viewModel = viewModel else { return }
        spendDetailMoveButton.rx.action = viewModel.requestSpendDetailMoveAction()
        addSpendMoveButton.rx.action = viewModel.requestAddSpendMoveMoveAction()
    }
    
    private func bindCollectionView() {
        let dummyData = ["default", "London", "Vienna", "Lisbon", "Lisbon", "Lisbon", "Lisbon", "Lisbon", "Lisbon", "Lisbon", "Lisbon", "Lisbon", "Lisbon", "Lisbon", "Lisbon", "Lisbon", "Lisbon", "Lisbon"]
        
        let sections = [
            SectionModel<String, String>(model: "first section", items: dummyData)
        ]
        
        collectionView
        .rx.setDelegate(self)
        .disposed(by: bag)
        
        Observable.just(sections)
            .bind(to: collectionView.rx.items(dataSource: mainDatasource))
            .disposed(by: bag)
    }
    
    typealias MainSectionModel = SectionModel<String, String>
    typealias MainCollectionViewDataSource = RxCollectionViewSectionedReloadDataSource<MainSectionModel>
    
    private var mainDatasource: MainCollectionViewDataSource {
        let configureCell: (CollectionViewSectionedDataSource<MainSectionModel>, UICollectionView, IndexPath, String) -> UICollectionViewCell =
        { (datasource, collectionView, indexPath,  element) in
            if indexPath.item == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.SUB_HEADER_CELL_NAME, for: indexPath)
                return cell
            } else {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.MAIN_CELL_NAME, for: indexPath) as? MainCollectionViewCell else { return UICollectionViewCell() }
                
                return cell
            }
        }
        
        let datasource = MainCollectionViewDataSource.init(configureCell: configureCell)
        
        datasource.configureSupplementaryView = {
            (dataSource,
            collectionView,
            kind,
            indexPath) -> UICollectionReusableView in
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: self.HEADER_CELL_NAME, for: indexPath)
            return header
        }
        
        return datasource
        
    }
    
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.item == 0 {
            return CGSize(width: UIScreen.main.bounds.width,
                               height: 116)
        }
        
        return CGSize(width: UIScreen.main.bounds.width * 0.408,
                      height: UIScreen.main.bounds.width * 0.408)
    }
}

