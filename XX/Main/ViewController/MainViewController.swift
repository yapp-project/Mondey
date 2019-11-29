//
//  MainViewController.swift
//  XX
//
//  Created by 박은비 on 19/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//
import UIKit

class MainViewController: BaseViewController {
 
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var pickerBackView: UIView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var pickerDoneButton: UIButton!
    
    let HEADER_CELL_NAME = "MainHeaderCell"
    let MAIN_CELL_NAME = "MainCollectionViewCell"
    
    let MAIN_CELL_WIDTH = UIScreen.main.bounds.width * 0.405
    var viewModel: MainViewModel?
    
    var reloadCollectionViewClosure: (() -> Void)?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        bindCollectionView()
        bindPickerView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
  
}

extension MainViewController: ViewModelBindableType {
    func bindViewModel() {
        guard let viewModel = viewModel else { return }
        
        MondeyHelper.shared.mondeyMainAddHelper = {
            (categoryIdx, idx, name, money) -> Void in
            
            var category = Category()
            
            category.id              = idx
            category.catTintColor    = MondeyHelper.mondeyCategoryTitleColor[categoryIdx-1]
            category.name            = name
            category.active          = true
            category.budget          = money
            category.period          = nil
            
            
            viewModel.addItem(category: category)
        }
        
        MondeyHelper.shared.mondeyMainRemoveHelper = {
            (idx) -> Void in
            viewModel.removeItem(at: idx)
        }
        
        
        pickerDoneButton.rx.action = viewModel.requestPickerDoneButton()
    }
    
    
    private func bindCollectionView() { 
        guard let viewModel = viewModel else { return }
        
        viewModel.sectionListSubject.asObserver()
        .bind(to: collectionView.rx.items(dataSource: mainDatasource)).disposed(by: rx.disposeBag)

        
        collectionView
            .rx.setDelegate(self)
            .disposed(by: rx.disposeBag)
        
        
        
        collectionView
            .rx.itemSelected.bind { (indexPath) in
                // 셀쪽 이벤트 RX에 대해 알아봐야할듯 이 방법이 맞는지 모르겠음 -> 현재 동작하지않음 Cell안애 이벤트 넣어서 동작
//                if viewModel.isMainCellRemoveMode.value {
//                    viewModel.requestSpendDetailMoveAction(cellValue: <#BehaviorRelay<Category>#>).execute()
//                }
            }
            .disposed(by: rx.disposeBag)
        
    }
    
    typealias MainSectionModel = SectionModel<String, Category>
    typealias MainCollectionViewDataSource = RxCollectionViewSectionedReloadDataSource<MainSectionModel>
    
    private var mainDatasource: MainCollectionViewDataSource {
        let configureCell: (CollectionViewSectionedDataSource<MainSectionModel>, UICollectionView, IndexPath, Category) -> UICollectionViewCell =
        { (datasource,
            collectionView,
            indexPath,
            element) in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.MAIN_CELL_NAME, for: indexPath) as? MainCollectionViewCell
                else { return UICollectionViewCell() }
            //            print("element 조회 \(element)")
            
            cell.cellIdx = indexPath.item
            if let viewModel = self.viewModel {
                cell.viewModel = viewModel
                cell.category.accept(element)
                
                cell.filterCateogryAllValue.accept(
                    MemoryStorage.shared.expenditures
                    .filter{ $0.id == element.id }
                    .map{ $0.cost }
                    .reduce(0, { $0 + $1 })
                )
                
                viewModel
                    .isMainCellRemoveMode
                    .subscribe
                    { (value) in
                        cell.removeCellButton.rx.isHidden.on(value)
                        
                        let reverseValue = Event.next( !(value.element!) )
                        cell.moveDetailButton.rx.isHidden.on(reverseValue)
                    }
                    .disposed(by: self.rx.disposeBag)
            }
            
            return cell
        }
        
        let datasource = MainCollectionViewDataSource.init(configureCell: configureCell)
        
        
        datasource.configureSupplementaryView = {
            (dataSource,
            collectionView,
            kind,
            indexPath) -> UICollectionReusableView in
            if let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: self.HEADER_CELL_NAME, for: indexPath) as? MainHeaderReusableView {
                
                if let viewModel = self.viewModel {
                    header.viewModel = viewModel
                }
                
                return header
            }
            
            return UICollectionReusableView()
        }
        
        return datasource
        
    }
    
    func bindPickerView() {
        guard let viewModel = viewModel else { return }
        
        pickerBackView.frame = CGRect.init(x: 0,
                                           y: UIScreen.main.bounds.height - pickerBackView.frame.height,
                                           width: UIScreen.main.bounds.width,
                                           height: pickerBackView.frame.height)
        self.view.addSubview(pickerBackView)
        
        viewModel.categoryArray.asObservable()
            .bind(to: pickerView.rx.itemTitles) { (row, element) in 
                return element.title == "" ? element.name : element.title
            }.disposed(by: rx.disposeBag)
        
        pickerView.rx.itemSelected.subscribe(onNext: { (row, element) in
//            print("element \(row)")
            print("element \(viewModel.categoryArray.value[row])")
            viewModel.selectedMainPicker.accept(viewModel.categoryArray.value[row])
            
        }).disposed(by: rx.disposeBag)
        
        viewModel.isHiddenMainPickerView.asObservable().bind(to: self.pickerBackView.rx.isHidden)
        .disposed(by: rx.disposeBag)
        
        
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
