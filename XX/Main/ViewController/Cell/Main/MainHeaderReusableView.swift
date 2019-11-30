//
//  MainHeaderReusableView.swift
//  XX
//
//  Created by 박은비 on 27/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import UIKit
import CenteredCollectionView

enum MainHeaderMode: Int {
    case spend = 0
    case saving = 1
}

class MainHeaderReusableView: UICollectionReusableView {
    let FIRST_CELL_NAME = "MainHeaderCollectionViewFirstCell"
    let SECOND_CELL_NAME = "MainHeaderCollectionViewSecondCell"
    
    let cellPercentWidth: CGFloat = 0.845
    let cellPercntSpacing: CGFloat = 0.037
    
    var centeredCollectionViewFlowLayout: CenteredCollectionViewFlowLayout!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var addSpendMoveButton: UIButton!
    
    @IBOutlet weak var spendButton: UIButton!
    @IBOutlet weak var savingButton: UIButton!
    
    @IBOutlet weak var removeModeButton: UIButton!
    
    @IBOutlet weak var useMoneyLabel: UILabel!
    @IBOutlet weak var userBudgetLabel: UILabel!
    
    
    // 뷰모델 너무 많아질것을 고려하여 MainViewModel 갖다놓긴 함
    var viewModel: MainViewModel? = nil{
        didSet{
            bindViewModel()
        }
    }
    let bag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setLayoutCollectionView()
        setLayout()
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
    
    func setLayout() {
        //self.userBudgetLabel.text = String(UserDefaultManager.budget)
    }
    
}


extension MainHeaderReusableView: ViewModelBindableType {
    func bindViewModel() {
        guard let viewModel = viewModel else { return }
        addSpendMoveButton.rx.action = self.viewModel?.requestAddSpendMoveMoveAction()
        
        let closureMoveCollectionViewChange: ((MainHeaderMode)->Void) = { [unowned self] (mode) in
            self.moveCollectionViewPage(mode)
        }
        spendButton.rx.action = viewModel.requestMainHeaderSwipeMoveAction(closureMoveCollectionViewChange, mode: .spend)
        savingButton.rx.action = viewModel.requestMainHeaderSwipeMoveAction(closureMoveCollectionViewChange, mode: .saving)
        removeModeButton.rx.action = viewModel.requestMainRemoveModeButtonAction()


        //        @IBOutlet weak var useMoneyLabel: UILabel!
        //        @IBOutlet weak var userBudgetLabel: UILabel!
        
        
        MemoryStorage.shared.categoryList().subscribe{ [unowned self] (value) in
            //            print("값에 변화가 있수다 MainHeader \(value.element?.map{ $0.budget }.reduce(0, { $0 + $1 }))")
            
            if value.element != nil {
                print("값에 변화가 있수다 MainHeader \(value.element?.count)")
                            let useMoney: Int? = value.element?.map{ $0.budget }.reduce(0, { $0 + $1 }) // 버그 : 두번째 nil로 들어옴
                            if let useMoney = useMoney {
                                self.userBudgetLabel.text = String(useMoney)
                            }
            }
            
            }.disposed(by: rx.disposeBag)
        
        MemoryStorage.shared.expenditureList().subscribe{ [unowned self] (value) in
            //            print("값에 변화가 있수다 MainHeader \(value.element?.map{ $0.budget }.reduce(0, { $0 + $1 }))")
            
            if value.element != nil {
                print("값에 변화가 있수다 MainHeader \(value.element?.count)")
                            let useMoney: Int? = value.element?.map{ $0.cost }.reduce(0, { $0 + $1 }) // 버그 : 두번째 nil로 들어옴
                            if let useMoney = useMoney {
                                self.useMoneyLabel.text = String(useMoney)
                            }
            }
            
            }.disposed(by: rx.disposeBag)
        
    }
    
    
    
    private func bindCollectionView() {
        let dummyData = ["page - 1", "page - 2"]
        
        let sections = [
            SectionModel<String, String>(model: "first section", items: dummyData)
        ]
        
        collectionView
            .rx
            .didEndDecelerating
            .bind { () in
                if let mainHeaderMode = MainHeaderMode(rawValue: self.centeredCollectionViewFlowLayout.currentCenteredPage ?? 0) {
                    self.changeCollectionViewTitle(mainHeaderMode)
                }
            }.disposed(by: rx.disposeBag)
        
        collectionView
            .rx
            .didEndScrollingAnimation
            .bind { () in
            }.disposed(by: rx.disposeBag)
        
        collectionView
            .rx.itemSelected.bind { [unowned self] (indexPath) in
                self.moveCollectionViewPage(MainHeaderMode(rawValue: indexPath.row) ?? .spend)
            }.disposed(by: rx.disposeBag)
        
        Observable.just(sections)
            .bind(to: collectionView.rx.items(dataSource: mainDatasource))
            .disposed(by: rx.disposeBag)
    }
    

    func moveCollectionViewPage(_ mainHeaderMode: MainHeaderMode = .spend) {
        self.centeredCollectionViewFlowLayout.scrollToPage(index: mainHeaderMode.rawValue, animated: true)
        self.changeCollectionViewTitle(mainHeaderMode)
    }
    
    func changeCollectionViewTitle(_ mainHeaderMode: MainHeaderMode = .spend) {
        DispatchQueue.main.async {
            self.spendButton.setTitleColor(mainHeaderMode == .spend ? #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.8470588235) : #colorLiteral(red: 0.6, green: 0.6, blue: 0.6, alpha: 0.8470588235), for:  .normal)
            self.savingButton.setTitleColor(mainHeaderMode == .saving ? #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.8470588235) : #colorLiteral(red: 0.6, green: 0.6, blue: 0.6, alpha: 0.8470588235), for:  .normal)
        }
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
                cell.viewModel = self.viewModel
                
                return cell
                
            } else {
                guard let cell = collectionView
                    .dequeueReusableCell(withReuseIdentifier: self.SECOND_CELL_NAME,
                                         for: indexPath) as? MainHeaderCollectionViewSecondCell
                    else {
                        return UICollectionViewCell()
                }

                cell.rx.tapGesture()
                    .when(.recognized)
                    .materialize()
                    .filter { $0.error == nil }
                    .dematerialize()
                    .subscribe(onNext: { [unowned self] _ in
                        self.viewModel?.presentingMonthly().execute()
                    })
                    .disposed(by: self.rx.disposeBag)

                return cell
            }
        }

        let datasource = MainHeaderCollectionViewDataSource.init(configureCell: configureCell)

        return datasource
    }
}

