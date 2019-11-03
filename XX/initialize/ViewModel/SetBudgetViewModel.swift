//
//  SetBudgetViewModel.swift
//  XX
//
//  Created by Seonghun Kim on 19/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import Foundation

class SetBudgetViewModel: BaseViewModel {
    let incomeValue = BehaviorRelay(value: 0)
    let categories = BehaviorRelay<[Category]>(value: [])
    let budgets = BehaviorRelay<[Int]>(value: [0, 0, 0, 0, 0, 0, 0])
    
    var subViewModels = [Int: BudgetTableViewCellViewModel]()
    
    func incomeString() -> Observable<String> {
        return incomeValue
            .map(decimal)
    }
    
    func categoryList() -> Observable<[Category]> {
        return categories.asObservable()
            .withLatestFrom(budgets, resultSelector: mergeCategoryAndBudget)
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
            .map { "매달 \($0)만원 저축" }
    }
    
    func addSubViewModels(index: Int, subViewModel: BudgetTableViewCellViewModel) {

        subViewModel.budsetString()
            .subscribe(onNext: { [unowned self] in
                self.updateBudget(index: index, budget: $0)
            })
            .disposed(by: subViewModel.rx.disposeBag)
        
        subViewModels[index] = subViewModel
    }
    
    func presentPeriodAction() -> CocoaAction {
        return CocoaAction { [unowned self] action in
            return Observable.just(action)
                .withLatestFrom(self.categories)
                .withLatestFrom(self.budgets, resultSelector: self.mergeCategoryAndBudget)
                .flatMap(self.moveToPeriodView)
        }
    }
    
    private func moveToPeriodView(categories: [Category]) -> Observable<Void> {
        let viewModel = SetPeriodViewModel(title: "점검 주기 설정", viewModel: self)
        viewModel.categories.accept(categories)
        let scene = InitializeScene.period(viewModel)
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
