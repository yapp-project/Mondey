//
//  MainScene.swift
//  XX
//
//  Created by 박은비 on 19/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import UIKit
enum MainScene {
    case main(MainViewModel)
    case spendDetail(SpendDetailViewModel)
    case appSpend(AddSpendViewModel)
    case choiceModal(MainViewModel)
    case spendChoiceModal(SpendDetailViewModel)
}

extension MainScene: SceneType {
    func instantiate(from storyboard: String) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        
        switch self {
        case .main(let viewModel):
            guard let navigationController = storyboard.instantiateViewController(withIdentifier: "MainViewController") as? UINavigationController,
                var viewController = navigationController.viewControllers.first as? MainViewController
                else {
                    return UIViewController()
            }
            
            viewController.bind(viewModel: viewModel)
            return navigationController
        case  .spendDetail(let viewModel):
            guard var viewController = storyboard.instantiateViewController(withIdentifier: "SpendDetailViewController") as? SpendDetailViewController else {
                return UIViewController()
            }

            viewController.bind(viewModel: viewModel)
            return viewController
        case  .appSpend(let viewModel):
            guard var viewController = storyboard.instantiateViewController(withIdentifier: "AddSpendViewController") as? AddSpendViewController else {
                return UIViewController()
            }
            
            viewController.bind(viewModel: viewModel)
            return viewController
        case .choiceModal(let viewModel):
            guard var viewController = storyboard.instantiateViewController(withIdentifier: "ChoiceDataViewController") as? ChoiceDataViewController else {
                return UIViewController()
            }
            viewController.bind(viewModel: viewModel)
            viewController.modalPresentationStyle = .overCurrentContext
            
            return viewController
        case .spendChoiceModal(let viewModel):
            guard var viewController = storyboard.instantiateViewController(withIdentifier: "SpendDetailDateSelectedPopupView") as? SpendDetailDateSelectedPopupView else {
                return UIViewController()
            }
            viewController.bind(viewModel: viewModel)
            viewController.modalPresentationStyle = .overCurrentContext
            
            return viewController
        }
        
    }
    
    func instantiate() -> UIViewController {
        return instantiate(from: "Main")
    }
}

