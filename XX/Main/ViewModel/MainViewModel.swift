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
    let categoryArray = BehaviorRelay<[Category]>(value: MemoryStorage.shared.categories)
    var reloadCollectionViewClosure: (() -> Void)?  // 메인 컬렉션뷰리로드
    let sectionListSubject = BehaviorSubject(value: [SectionModel(model: "First section", items: MemoryStorage.shared.categories)])
    
    // 메인 피커뷰 숨김, 나타남 값
    let isHiddenMainPickerView = BehaviorRelay<Bool>(value: true)
    
    // 메인 피커뷰 select시 바뀌어질 값
    let selectedMainPicker = BehaviorRelay<Category>(value: .init())
    
    
    func removeItem(at idx: Int) {
        guard var sections = try? sectionListSubject.value() else { return }
        
        var currentSection = sections[0] // 100% 하나는 있기떄문
        currentSection.items.remove(at: idx)
        sections[0] = currentSection
        
        let category = MemoryStorage.shared.categories.remove(at: idx)
    
        MemoryStorage.shared.expenditures = MemoryStorage.shared.expenditures.filter{ $0.id != category.id }
        categoryArray.accept(currentSection.items)
        sectionListSubject.onNext(sections)
    }
    
    func addItem(category: Category) {
        guard var sections = try? sectionListSubject.value() else { return }
        
        var currentSection = sections[0] // 100% 하나는 있기떄문
        currentSection.items.append(category)
        sections[0] = currentSection
        
        MemoryStorage.shared.categories.append(category)
        
        categoryArray.accept(currentSection.items)
        sectionListSubject.onNext(sections)
    }
    
    // 걍 리로딩용..
    func replaceItem() {
        guard var sections = try? sectionListSubject.value() else { return }
        
        let currentSection = sections[0] // 100% 하나는 있기떄문
        sections[0] = currentSection
        
        categoryArray.accept(currentSection.items)
        sectionListSubject.onNext(sections)
    }
    
    
    func requestPickerDoneButton() -> CocoaAction {
        return Action { [unowned self] action in
            self.isHiddenMainPickerView.accept(!(self.isHiddenMainPickerView.value))
            return Observable.just(action)
        }
    }
    
    func requestSpendDetailMoveAction(cellValue: BehaviorRelay<Category>) -> CocoaAction {
        return Action { _ in
            var viewModel = SpendDetailViewModel(title: "지출디테일", sceneCoordinator: self.sceneCoordinator, storage: self.storage)
            viewModel.spendDetailCategory = cellValue
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
    var isMainCellRemoveMode = BehaviorRelay<Bool>(value: true)
    
    func requestMainCellRemoveModeButtonAction(title: String,
                                               cellIdx: Int,
                                               button: inout UIButton) -> CocoaAction {
        return Action { action in
            
//
//            self.showAlert(title: title,
//                           message: "정말로 지우시겠습니까?")
            
            UIAlertController
                .alert(title: title,
                       message: "정말로 지우시겠습니까?",
                       style: .alert)
                .action(title: "확인", style: .default) { _ in
                    self.removeItem(at: cellIdx)
                }
                .action(title: "취소", style: .default) { _ in }
                .present(to: MondeyHelper.getTopViewController() )
            
            
            
            MemoryStorage.shared.categoryList().subscribe{ [unowned self] (value) in
                if let value = value.element {
                    print("값에 변화가 있수다 MainHeader3333 \(value.count)")
                    
                    //            print("값에 변화가 있수다 MainHeader \(value.element?.map{ $0.budget }.reduce(0, { $0 + $1 }))")
                    
                    //            let useMoney: Int? = value.element?.map{ $0.budget }.reduce(0, { $0 + $1 }) // 버그 : 두번째 nil로 들어옴
                    //            if let useMoney = useMoney {
                    //                self.useMoneyLabel.text = String(useMoney)
                    //            }
                    
                    
                    
                    // 값변화시 나의 소비평가  갱신
                }

                
                }.disposed(by: self.rx.disposeBag) 
            
            
            
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
        return Action { [unowned self] action in 
            self.isMainCellRemoveMode.accept(!self.isMainCellRemoveMode.value)
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
//    let howTextField = BehaviorRelay<Category>(value: .init()) -> selectedMainPicker
    let whatTextField = BehaviorRelay<String>(value: "")
    let moneyTextField = BehaviorRelay<String>(value: "")
    
    func requestMainHeaderCellOkAction() -> CocoaAction {
        return Action { [unowned self] _ in
            // 예외처리
            
            if  (self.selectedMainPicker.value.title == "" && self.selectedMainPicker.value.name == "") ||
                self.whatTextField.value == "" ||
                self.moneyTextField.value == "" {
                
                UIAlertController
                    .alert(title: "",
                           message: "값을 확인해주세요.",
                           style: .alert)
                    .action(title: "확인", style: .default) { _ in }
                    .present(to: MondeyHelper.getTopViewController() )
                
                  return Observable.empty()
                
            }
            
//            let viewModel = MainViewModel(title: "썼어요", sceneCoordinator: self.sceneCoordinator, storage: self.storage)
            let scene = MainScene.choiceModal(self)
            
            
            return self
                .sceneCoordinator
                .transition(to: scene,
                            using: .modal,
                            animated: false)
                .asObservable().map { _ in }
            
            
            return Observable.empty()
            
        }
    }
    
    func requestMainHeaderisMainTicker() -> CocoaAction {
        return Action {[unowned self] action in
            if self.isHiddenMainPickerView.value == true {
                self.isHiddenMainPickerView.accept(false)
            }
            
            return Observable.just(action)
        }
    }
//    requestBackButtonAction()
    // MARK: ChoiceDataViewController
    func requestBackButtonAction() -> CocoaAction {
        return Action { _ in
            return self.sceneCoordinator.close(animated: false).asObservable().map { _ in }
        }
    }
    
    func requestAppendSobiButtonAction(selectedDate: Date) -> CocoaAction {
        return Action { _ in
//            2019-11-09 19:11
            
            //selectedDate 시간은 11월만 나오게끔해야하기에 현재시간만 나오는것을 따로 고치지 않는다.
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            let dateString = "\(dateFormatter.string(from: selectedDate))"
            
            MemoryStorage.shared.expenditures.append(Expenditure.init(id: self.selectedMainPicker.value.id,
                                                                      desc: self.whatTextField.value,
                                                                      cost: Int(self.moneyTextField.value) ?? 0,
                                                                      date: dateString))
            
            print("MemoryStorage \(MemoryStorage.shared.expenditures)")
            
            
            // 들어간뒤 replaceItem 수행
            self.replaceItem()
            if let closure = MondeyHelper.shared.mondeyMainHeaderClean {
                closure()
            }
            
            return self.sceneCoordinator.close(animated: false).asObservable().map { _ in }
        }
    }
}

