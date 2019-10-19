//
//  MonthlyScene.swift
//  XX
//
//  Created by 이재은 on 06/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import UIKit

enum MonthlyScene {
    case Mmain(MonthlyViewModel)
    case Mdetail(MonthlyDetailViewModel)
    case PickYear(PickYearViewModel)
}

extension MonthlyScene: SceneType {
    func instantiate(from storyboard: String) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)

        switch self {
        case .Mmain(let viewModel):
            guard let navigationController = storyboard
                .instantiateViewController(withIdentifier: "MonthlyViewController") as? UINavigationController,
                var viewController = navigationController
                    .viewControllers.first as? MonthlyViewController
                else {
                    return UIViewController()
            }
            viewController.bind(viewModel: viewModel)
            return navigationController
        case .Mdetail(let viewModel):
            guard let navigationController = storyboard
                .instantiateViewController(withIdentifier: "MonthlyDetailViewController") as? UINavigationController,
                var viewController = navigationController
                    .viewControllers.first as? MonthlyDetailViewController
                else {
                    return UIViewController()
            }
            viewController.bind(viewModel: viewModel)
            return navigationController
        case .PickYear(let viewModel):
            guard let navigationController = storyboard
                .instantiateViewController(withIdentifier: "PickYearViewController") as? UINavigationController,
                var viewController = navigationController
                    .viewControllers.first as? PickYearViewController
                else {
                    return UIViewController()
            }
            viewController.bind(viewModel: viewModel)
            return navigationController
        }
    }

    func instantiate() -> UIViewController {
        return instantiate(from: "Monthly")
    }
}
