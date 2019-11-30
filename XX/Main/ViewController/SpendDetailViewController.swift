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
//        print("viewModel \(viewModel.spendDetailCategory.value)")
//        backButton.rx.action = viewModel.requestBackButtonAction()
        
        viewModel.spendDetailCategory.subscribe { (value) in
            guard var sections = try? viewModel.sectionListSubject.value() else { return }
            
            var currentSection = sections[0] // 100% 하나는 있기떄문
            let expenditureArray = MemoryStorage.shared.expenditures.filter{
                $0.id == value.element?.id &&
                self.dateToday(day1: viewModel.selectedDate.value, date2: $0.date )
            }
            
            currentSection.items = expenditureArray
            sections[0] = currentSection
            
            viewModel.sectionListSubject.onNext(sections)
        }.disposed(by: rx.disposeBag)
        
        
        viewModel.selectedDate.subscribe{ (value) in
            guard var sections = try? viewModel.sectionListSubject.value() else { return }
            
            var currentSection = sections[0] // 100% 하나는 있기떄문
            let expenditureArray = MemoryStorage.shared.expenditures.filter{
                    $0.id == viewModel.spendDetailCategory.value.id &&
                    self.dateToday(day1: value.element! , date2: $0.date )
            }
            
            currentSection.items = expenditureArray
            sections[0] = currentSection
            
            viewModel.sectionListSubject.onNext(sections)
       }.disposed(by: rx.disposeBag)
    }
    
    
    
    func dateToday( day1: Date, date2: Date) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.string(from: day1) == dateFormatter.string(from: date2)
    }
    
    func dateHHmm( date: Date ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        return dateFormatter.string(from: date)
    }
    
    
    private func bindCollectionView() {
        guard let viewModel = viewModel else { return }
//        let dummyData =  ["default",
//                          "London",
//                          "Vienna",
//                          "Lisbon",
//                          "Lisbon",
//                          "Lisbon",
//                          "Lisbon",
//                          "Lisbon",
//                          "Lisbon",
//                          "Lisbon"]
//
//        //뷰모델을 전달하면..?
//        let sections = [
//            SectionModel<String, String>(model: "Fisrt", items: dummyData)
//        ]
//
//        Observable.just(sections)
//            .bind(to: collectionView.rx.items(dataSource: spendDetailDatasource))
//            .disposed(by: bag)
        
        
        
        viewModel.sectionListSubject.asObserver()
            .bind(to: collectionView.rx.items(dataSource: spendDetailDatasource)).disposed(by: rx.disposeBag)
        
//        collectionView
//            .rx.setDelegate(self)
//            .disposed(by: rx.disposeBag)
        
    }
    
    typealias CollectionModel = SectionModel<String, Expenditure>
    typealias CollectionViewDataSource = RxCollectionViewSectionedReloadDataSource<CollectionModel>
    
    private var spendDetailDatasource: CollectionViewDataSource {
        let configureCell: (CollectionViewSectionedDataSource<CollectionModel>, UICollectionView, IndexPath, Expenditure) -> UICollectionViewCell =
        { (datasource,
            collectionView,
            indexPath,
            element) in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SpendDetailCell", for: indexPath) as? SpendDetailCell
                else { return UICollectionViewCell() }
            
            cell.cellDate.text = self.dateHHmm(date: element.date)
            cell.cellDesc.text = element.desc
            cell.cellCost.text = "-\(element.cost)"
            
            return cell
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

