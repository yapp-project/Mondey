//
//  SceneCoodinator.swift
//  XX
//
//  Created by Seonghun Kim on 06/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SceneCoodinator: NSObject {
    private var window: UIWindow
    private var currentVC: UIViewController
    
    required init(window: UIWindow) {
        self.window = window
        currentVC = window.rootViewController!
    }
}

extension SceneCoodinator: SceneCoordinatorType {
    @discardableResult
    func transition(to scene: SceneType, using style: TransitionStyle, animated: Bool) -> Completable {
        let subject = PublishSubject<Void>()
        
        let target = scene.instantiate()
        
        switch style {
        case .root:
            currentVC = target.sceneViewController
            window.rootViewController = target
            subject.onCompleted()
        case .push:
            guard let nav = currentVC.navigationController else {
                subject.onError(TransitionError.navigationControllerMissing)
                break
            }
            
            nav.rx.willShow
                .subscribe(onNext: { [unowned self] evt in
                    self.currentVC = evt.viewController.sceneViewController
                })
                .disposed(by: rx.disposeBag)
            
            nav.pushViewController(target, animated: animated)

            subject.onCompleted()
        case .modal:
            currentVC.present(target, animated: animated) {
                subject.onCompleted()
            }
            currentVC = target.sceneViewController
            currentVC.modalPresentationStyle = .overFullScreen
        }
        
        return subject.ignoreElements()
    }
    
    @discardableResult
    func close(animated: Bool) -> Completable {
        return Completable.create { [unowned self] completable in
            if let presentingVC = self.currentVC.presentingViewController {
                self.currentVC.dismiss(animated: animated) {
                    self.currentVC = presentingVC.sceneViewController
                    completable(.completed)
                }
            } else if let nav = self.currentVC.navigationController {
                guard nav.popViewController(animated: animated) != nil else {
                    completable(.error(TransitionError.cannotPop))
                    return Disposables.create()
                }
                
                self.currentVC = nav.viewControllers.last!
                completable(.completed)
            } else {
                completable(.error(TransitionError.unknown))
            }
            
            return Disposables.create()
        }
    }
}
