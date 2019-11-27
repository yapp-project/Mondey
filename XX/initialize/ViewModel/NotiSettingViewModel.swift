//
//  SetNotiViewModel.swift
//  XX
//
//  Created by Seonghun Kim on 19/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import Foundation
import UserNotifications

class NotiSettingViewModel: BaseViewModel {
    let incomeValue = BehaviorRelay(value: 0)
    let categories = BehaviorRelay<[Category]>(value: [])
    let notiTime = BehaviorRelay(value: Date())
    let isAllowedOption = BehaviorRelay(value: true)
    
    func updateAlertOptionAction() -> CocoaAction {
        return CocoaAction { [unowned self] action in
            return Observable.just(action)
                .map(self.toggleAlertOption)
        }
    }
    
    func presentFinishAction() -> CocoaAction {
        let income = self.incomeValue.value
        let categoryList = self.categories.value
        let alertTime = self.notiTime.value
        let activeNoti = self.isAllowedOption.value
        
        return CocoaAction { [unowned self] _ in
            if activeNoti {
                self.setNotification(at: alertTime)
            }
            
            let viewModel = SignUpSettingCompletionViewModel(title: "설정완료", viewModel: self)
            viewModel.incomeValue.accept(income)
            viewModel.categories.accept(categoryList)
            let scene = SignUpSettingScene.finish(viewModel)
            
            return self.sceneCoordinator.transition(to: scene, using: .modal, animated: true).asObservable().map { _ in }
        }
    }
    
    private func toggleAlertOption() {
        isAllowedOption.accept(!isAllowedOption.value)
    }
    
    private func setNotification(at date: Date) {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.hour = calendar.component(.hour, from: date)
        dateComponents.minute = calendar.component(.minute, from: date)

        let center = UNUserNotificationCenter.current()
        let options: UNAuthorizationOptions = [.alert, .sound, .badge];
        
        center.requestAuthorization(options: options) {
            (granted, error) in
            if granted {
                let content = UNMutableNotificationContent()
                content.categoryIdentifier = "remind_notification"
                content.title = "Mondey"
                content.body = "Mondey에 오늘의 지출을 기록해 주세요!"
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                let request = UNNotificationRequest(identifier: "monday_remind_notification", content: content, trigger: trigger)
                let center = UNUserNotificationCenter.current()
                center.add(request) { (error) in
                    print(error?.localizedDescription ?? "")
                }
            }
        }
    }
}
