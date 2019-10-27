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
    
    let CELL_NAME = "MainCell"
    
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
        
        let firstCities = ["default", "London", "Vienna", "Lisbon", "Lisbon", "Lisbon", "Lisbon", "Lisbon", "Lisbon", "Lisbon", "Lisbon", "Lisbon", "Lisbon", "Lisbon", "Lisbon", "Lisbon", "Lisbon", "Lisbon"]
//        let secondCities = ["Paris", "Madrid", "Seoul"]
        
        let sections = [
            SectionModel<String, String>(model: "first section", items: firstCities)
        ]
        
        
        
        Observable.just(sections)
            .bind(to: collectionView.rx.items(dataSource: mainDatasource))
            .disposed(by: bag)
    }
    
    typealias MainSectionModel = SectionModel<String, String>
    typealias MainDataSource = RxCollectionViewSectionedReloadDataSource<MainSectionModel>
    
    private var mainDatasource: MainDataSource {
        let configureCell: (CollectionViewSectionedDataSource<MainSectionModel>, UICollectionView, IndexPath, String) -> UICollectionViewCell = { (datasource, collectionView, indexPath,  element) in
            //            guard
            
            if indexPath.item == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.SUB_HEADER_CELL_NAME, for: indexPath)
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.CELL_NAME, for: indexPath)
                //                    as? NameCell else { return UITableViewCell() }
                
                //            cell.textLabel?.text = element
                
                return cell
            }
        }
        
        let datasource = MainDataSource.init(configureCell: configureCell)
        
        datasource.configureSupplementaryView = {(dataSource, collectionView, kind, indexPath) -> UICollectionReusableView in
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: self.HEADER_CELL_NAME, for: indexPath)
            //                as! HeaderCell
            //            header.setup()
            return header
        }
        
//        sizeForItemAtIndexPath
        
    

        
        return datasource
        
    }
    
}

//extension MainViewController: UICollectionViewDelegate {
//    // 섹션 수 설정
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//    
//    // 섹션에 따라 셀 수 정함
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 2
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CELL_NAME, for: indexPath as IndexPath)
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print("Cell \(indexPath.row) selected")
//    }
//}
//
//
//extension MainViewController: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        if kind == UICollectionView.elementKindSectionHeader {
//            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
//                                                                             withReuseIdentifier:HEADER_CELL_NAME,
//                                                                             for: indexPath)
//            
//            return headerView
//        } else {
//            return UICollectionReusableView()
//        }
//    }
//}
