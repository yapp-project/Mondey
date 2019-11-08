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
    case finish(SignUpSettingCompletionViewModel)
}

extension SignUpSettingScene: SceneType {
    func instantiate(from storyboard: String) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        
        switch self {
        case .income(let viewModel):
            guard let navigationController = storyboard.instantiateViewController(withIdentifier: "IncomeSettingViewController") as? UINavigationController,
                var viewController = navigationController.viewControllers.first as? IncomeSettingViewController
                else {
                    return .init()
            }
            viewController.bind(viewModel: viewModel)
            return navigationController
        case .category(let viewModel):
            guard var viewController = storyboard.instantiateViewController(withIdentifier: "CategoriesSettingViewController") as? CategoriesSettingViewController else { return .init() }
            viewController.bind(viewModel: viewModel)
            return viewController
        case .budget(let viewModel):
            guard var viewController = storyboard.instantiateViewController(withIdentifier: "BudgetSettingViewController") as? BudgetSettingViewController else { return .init() }
            viewController.bind(viewModel: viewModel)
            return viewController
        case .period(let viewModel):
            guard var viewController = storyboard.instantiateViewController(withIdentifier: "PeriodSettingViewController") as? PeriodSettingViewController else { return .init() }
            viewController.bind(viewModel: viewModel)
            return viewController
        case .notiSetting(let viewModel):
            guard var viewController = storyboard.instantiateViewController(withIdentifier: "NotiSettingViewController") as? NotiSettingViewController else { return .init() }
            viewController.bind(viewModel: viewModel)
            return viewController
        case .finish(let viewModel):
            guard var viewController = storyboard.instantiateViewController(withIdentifier: "SignUpSettingCompletionViewController") as? SignUpSettingCompletionViewController else { return .init() }
            viewController.bind(viewModel: viewModel)
            return viewController
        }
    }
    
    func instantiate() -> UIViewController {
        return instantiate(from: "SignUpSetting")
    }
}
