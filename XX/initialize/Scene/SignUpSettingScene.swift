//
//  InitializeScene.swift
//  XX
//
//  Created by Seonghun Kim on 19/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import UIKit

enum SignUpSettingScene {
    case income(IncomeSettingViewModel)
    case category(CategoriesSetting)
    case budget(BudgetSettingViewModel)
    case period(PeriodSettingViewModel)
    case notiSetting(NotiSettingViewModel)
    case finish(FinishInitViewModel)
}

extension SignUpSettingScene: SceneType {
    func instantiate(from storyboard: String) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        
        switch self {
        case .income(let viewModel):
            guard let navigationController = storyboard.instantiateViewController(withIdentifier: "InitializeViewController") as? UINavigationController,
                var viewController = navigationController.viewControllers.first as? IncomeSettingViewController
                else {
                    return .init()
            }
            viewController.bind(viewModel: viewModel)
            return navigationController
        case .category(let viewModel):
            guard var viewController = storyboard.instantiateViewController(withIdentifier: "SetCategoriesViewController") as? CategoriesSettingViewController else { return .init() }
            viewController.bind(viewModel: viewModel)
            return viewController
        case .budget(let viewModel):
            guard var viewController = storyboard.instantiateViewController(withIdentifier: "SetBudgetViewController") as? BudgetSettingViewController else { return .init() }
            viewController.bind(viewModel: viewModel)
            return viewController
        case .period(let viewModel):
            guard var viewController = storyboard.instantiateViewController(withIdentifier: "SetPeriodViewController") as? PeriodSettingViewController else { return .init() }
            viewController.bind(viewModel: viewModel)
            return viewController
        case .notiSetting(let viewModel):
            guard var viewController = storyboard.instantiateViewController(withIdentifier: "SetNotiViewController") as? NotiSettingViewController else { return .init() }
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
