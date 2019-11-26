//
//  MainViewModel.swift
//  XX
//
//  Created by 박은비 on 19/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import UIKit

class MainViewModel: BaseViewModel {
    let category = BehaviorRelay<Category>(value: .init())
    
//    func requestSpendDetailMoveAction() -> Action<IndexPath, Void> {
    func requestSpendDetailMoveAction() -> CocoaAction {
        return Action { _ in
            let viewModel = SpendDetailViewModel(title: "지출디테일", sceneCoordinator: self.sceneCoordinator, storage: self.storage)
            let scene = MainScene.spendDetail(viewModel)
            
            return self
                .sceneCoordinator
                .transition(to: scene,
                            using: .push,
                            animated: true)
                .asObservable().map { _ in }
        }
    }
    
    func requestAddSpendMoveMoveAction() -> CocoaAction {
        return Action { _ in
            let viewModel = AddSpendViewModel(title: "추가지출", sceneCoordinator: self.sceneCoordinator, storage: self.storage)
            let scene = MainScene.appSpend(viewModel)
            
            return self
                .sceneCoordinator
                .transition(to: scene,
                            using: .push,
                            animated: true)
                .asObservable().map { _ in }
            
        }
    }
    
    // MARK: MainCollectionViewCell
    var mainCollectionView: UICollectionView? = nil
    var isMainCellRemoveMode: Bool = true {
        didSet {
            mainCollectionView?.reloadData()
        }
    }
    
    func requestMainCellRemoveModeButtonAction(cellIdx: Int,
                                           button: inout UIButton) -> CocoaAction {
        return Action { action in
            /*
                1. 여기서 지출 내역 데이터 삭제하기
                2. showAlart에 title 부여
                3. alert에 액션 부여
             */
            
            
//            self.showAlert(title: "test",
//                      message: "정말로 지우시겠습니까?")
            
            MemoryStorage.getInstance().categoryList().subscribe{ [unowned self] (value) in
                //            print("값에 변화가 있수다 MainHeader \(value.element?.map{ $0.budget }.reduce(0, { $0 + $1 }))")
                
                // 메인 뷰컨트롤러에서 구독한 값에대한 옵저버에서는 변화가 없으므로
                // 여기서 컨트롤 해줘야할듯
                // 같은 getINstance 일텐데.. 왜 안되는지 모르곘음
                print("값에 변화가 있수다 MainHeader3333")
                //            let useMoney: Int? = value.element?.map{ $0.budget }.reduce(0, { $0 + $1 }) // 버그 : 두번째 nil로 들어옴
                //            if let useMoney = useMoney {
                //                self.useMoneyLabel.text = String(useMoney)
                //            }
                
                }.disposed(by: self.rx.disposeBag)
            MemoryStorage.getInstance().categories.removeLast()
            
            
            
            return Observable.just(action)
        }
    }
    
    private func showAlert(title: String,
                           message: String) -> Observable<Void> {
        sceneCoordinator.showWarning(title: title, message: message)
        
        return Observable.empty()
    }
    
    
    // MARK: MainHeaderReusableView
    func requestMainRemoveModeButtonAction() -> CocoaAction {
        return Action { action in
            self.isMainCellRemoveMode = !self.isMainCellRemoveMode
            return Observable.just(action)
        }
    }
    
    func requestMainHeaderSwipeMoveAction(_ moveCollectionViewPage: @escaping ((MainHeaderMode)-> Void),
                                          mode: MainHeaderMode = .spend) -> CocoaAction {
        return Action { action in
            moveCollectionViewPage(mode) 
            return Observable.just(action)
        }
    }

    // MARK: MainHeaderCollectionViewFirstCell
    func requestMainHeaderCellOkAction() -> CocoaAction {
        return Action { _ in
            let viewModel = MainViewModel(title: "썼어요", sceneCoordinator: self.sceneCoordinator, storage: self.storage)
            let scene = MainScene.choiceModal(viewModel)
            
            
            return self
                .sceneCoordinator
                .transition(to: scene,
                            using: .modal,
                            animated: false)
                .asObservable().map { _ in }
            
        }
    }
//    requestBackButtonAction()
    // MARK: ChoiceDataViewController
    func requestBackButtonAction() -> CocoaAction {
        return Action { _ in
            return self.sceneCoordinator.close(animated: false).asObservable().map { _ in }
        }
    }
}

