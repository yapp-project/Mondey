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
}

extension InitializeScene: SceneType {
    func instantiate(from storyboard: String) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        
        switch self {
        case .income(let viewModel):
            guard let navigationController = storyboard.instantiateViewController(withIdentifier: "InitializeViewController") as? UINavigationController,
                var viewController = navigationController.viewControllers.first as? IncomeViewController
                else {
                    return UIViewController()
            }
            viewController.bind(viewModel: viewModel)
            return navigationController
        }
    }
    
    func instantiate() -> UIViewController {
        return instantiate(from: "Initialize")
    }
}
