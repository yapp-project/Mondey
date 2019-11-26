//
//  SetBudgetViewModel.swift
//  XX
//
//  Created by Seonghun Kim on 19/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import Foundation

class BudgetSettingViewModel: BaseViewModel {
    let incomeValue = BehaviorRelay(value: 0)
    let categories = BehaviorRelay<[Category]>(value: [])
    let budgets = BehaviorRelay<[Int]>(value: [0, 0, 0, 0, 0, 0, 0])
    
    var subViewModels = [Int: BudgetSettingCellViewModel]()
    
    func incomeString() -> Observable<String> {
        return incomeValue
            .map(decimal)
    }
    
    func categoryList() -> Observable<[Category]> {
        return categories.asObservable()
            .withLatestFrom(budgets, resultSelector: mergeCategoryAndBudget)
    }
    
    func validSetting() -> Observable<Bool> {
        return Observable.combineLatest(categories, budgets, resultSelector: {
            return $0.count == $1.filter({ $0 > 0 }).count
        })
    }
    
    func updateBudget(index: Int, budget: String) {
        let pureBudget = stringToInt(budget)
        var current = budgets.value
        current[index] = pureBudget
        
        budgets.accept(current)
    }
    
    func totalBudget() -> Observable<String> {
        return budgets
            .map { $0.reduce(into: 0, { $0 += $1 }) }
            .withLatestFrom(incomeValue) {
                (Int($1 / 10000) - $0)
            }
            .map(decimal)
    }
    
    func addSubViewModels(index: Int, subViewModel: BudgetSettingCellViewModel) {

        subViewModel.budsetString()
            .subscribe(onNext: { [unowned self] in
                self.updateBudget(index: index, budget: $0)
            })
            .disposed(by: subViewModel.rx.disposeBag)
        
        subViewModels[index] = subViewModel
    }
    
    #warning("시연을 위한 기간 설정 및 알림 설정 화면 생략")
//    func presentPeriodAction() -> CocoaAction {
//        return CocoaAction { [unowned self] action in
//            return Observable.just(action)
//                .withLatestFrom(self.categories)
//                .withLatestFrom(self.budgets, resultSelector: self.mergeCategoryAndBudget)
//                .flatMap(self.moveToPeriodView)
//        }
//    }
    
    func presentNotiSettingAction() -> CocoaAction {
        let income = self.incomeValue.value
        let categoryList = self.categories.value
        
        return CocoaAction { _ in
//            let viewModel = SignUpSettingCompletionViewModel(title: "설정완료", viewModel: self)
//            viewModel.incomeValue.accept(income)
//            viewModel.categories.accept(categoryList)
//            let scene = SignUpSettingScene.finish(viewModel)
//            
//            return self.sceneCoordinator.transition(to: scene, using: .modal, animated: true).asObservable().map { _ in }
            
            let viewModel = NotiSettingViewModel(title: "알림설정", viewModel: self)
            viewModel.incomeValue.accept(income)
            viewModel.categories.accept(categoryList)
            let scene = SignUpSettingScene.notiSetting(viewModel)
            
            return self.sceneCoordinator.transition(to: scene, using: .push, animated: true).asObservable().map { _ in }
        }
    }
    
    private func moveToPeriodView(categories: [Category]) -> Observable<Void> {
        let viewModel = PeriodSettingViewModel(title: "점검 주기 설정", viewModel: self)
        viewModel.categories.accept(categories)
        let scene = SignUpSettingScene.period(viewModel)
        self.sceneCoordinator.transition(to: scene, using: .push, animated: true)
        
        return Observable.empty()
    }
    
    private func mergeCategoryAndBudget(categories: [Category], budgets: [Int]) -> [Category] {
        var list = categories
        for budget in budgets.enumerated() {
            guard budget.0 < list.count else { break }
            list[budget.0].budget = budget.1
        }
        
        return list
    }
}
