//
//  SetPeriod.swift
//  XX
//
//  Created by Seonghun Kim on 19/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import Foundation

class PeriodSettingViewModel: BaseViewModel {
    let categories = BehaviorRelay<[Category]>(value: [])

    var subViewModels = [Int: PeriodSettingCellViewModel]()
    
    func addSubViewModels(index: Int, subViewModel: PeriodSettingCellViewModel) {
        subViewModel.periodType
            .subscribe(onNext: { [unowned self] period in
                self.updatePeriodes(index: index, period: period)
            })
            .disposed(by: subViewModel.rx.disposeBag)
        
        subViewModels[index] = subViewModel
    }
    
    func validSetting() -> Observable<Bool> {
        return categories.map { $0.count == $0.filter({ ($0.period != nil) && ($0.period != Category.Period.none) }).count }
    }
    
    private func updatePeriodes(index: Int, period: Category.Period?) {
        var categoryList = categories.value
        categoryList[index].period = period
        
        categories.accept(categoryList)
    }
    
    func presentNotiSettingAction() -> CocoaAction {
        return CocoaAction { _ in
            let viewModel = NotiSettingViewModel(title: "알림설정", viewModel: self)
            let scene = SignUpSettingScene.notiSetting(viewModel)
            
            return self.sceneCoordinator.transition(to: scene, using: .push, animated: true).asObservable().map { _ in }
        }
    }
}
