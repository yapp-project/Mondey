//
//  InitializeScene.swift
//  XX
//
//  Created by Seonghun Kim on 19/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import UIKit

enum InitializeScene {
    case income(IncomeViewModel)
    case category(SetCategoriesViewModel)
    case budget(SetBudgetViewModel)
    case period(SetPeriodViewModel)
    case notiSetting(SetNotiViewModel)
    case finish(FinishInitViewModel)
}

extension InitializeScene: SceneType {
    func instantiate(from storyboard: String) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        
        switch self {
        case .income(let viewModel):
            guard let navigationController = storyboard.instantiateViewController(withIdentifier: "InitializeViewController") as? UINavigationController,
                var viewController = navigationController.viewControllers.first as? IncomeViewController
                else {
                    return .init()
            }
            viewController.bind(viewModel: viewModel)
            return navigationController
        case .category(let viewModel):
            guard var viewController = storyboard.instantiateViewController(withIdentifier: "SetCategoriesViewController") as? SetCategoriesViewController else { return .init() }
            viewController.bind(viewModel: viewModel)
            return viewController
        case .budget(let viewModel):
            guard var viewController = storyboard.instantiateViewController(withIdentifier: "SetBudgetViewController") as? SetBudgetViewController else { return .init() }
            viewController.bind(viewModel: viewModel)
            return viewController
        case .period(let viewModel):
            guard var viewController = storyboard.instantiateViewController(withIdentifier: "SetPeriodViewController") as? SetPeriodViewController else { return .init() }
            viewController.bind(viewModel: viewModel)
            return viewController
        case .notiSetting(let viewModel):
            guard var viewController = storyboard.instantiateViewController(withIdentifier: "SetNotiViewController") as? SetNotiViewController else { return .init() }
            viewController.bind(viewModel: viewModel)
            return viewController
        case .finish(let viewModel):
            guard var viewController = storyboard.instantiateViewController(withIdentifier: "FinishInitViewController") as? FinishInitViewController else { return .init() }
            viewController.bind(viewModel: viewModel)
            return viewController
        }
    }
    
    func instantiate() -> UIViewController {
        return instantiate(from: "Initialize")
    }
}
