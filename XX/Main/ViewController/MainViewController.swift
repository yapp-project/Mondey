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
    let MAIN_CELL_NAME = "MainCollectionViewCell"
    
    let MAIN_CELL_WIDTH = UIScreen.main.bounds.width * 0.405
    
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
        let dummyData = ["default", "London", "Vienna", "Lisbon", "Lisbon", "Lisbon", "Lisbon", "Lisbon", "Lisbon", "Lisbon"]
        
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
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.MAIN_CELL_NAME, for: indexPath) as? MainCollectionViewCell else { return UICollectionViewCell() }
                
                return cell
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
        return CGSize(width: MAIN_CELL_WIDTH,
                      height: MAIN_CELL_WIDTH)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let padding = (UIScreen.main.bounds.width - (MAIN_CELL_WIDTH * 2)) / 4 + 10
        return UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
    }
}
