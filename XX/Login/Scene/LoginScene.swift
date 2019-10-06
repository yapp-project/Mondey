//
//  LoginScene.swift
//  XX
//
//  Created by Seonghun Kim on 06/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import UIKit

enum LoginScene {
    case signUp(SignUpViewModel)
    case signIn(SignInViewModel)
}

extension LoginScene: SceneType {
    func instantiate(from storyboard: String) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        
        switch self {
        case .signIn(let viewModel):
            guard let navigationController = storyboard.instantiateViewController(withIdentifier: "SignInViewController") as? UINavigationController,
            var viewController = navigationController.viewControllers.first as? SignInViewController
                else {
                    return UIViewController()
            }
            
            viewController.bind(viewModel: viewModel)
            return navigationController
        case  .signUp(let viewModel):
            guard var viewController = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController else { return UIViewController() }
            
            viewController.bind(viewModel: viewModel)
            return viewController
        }
    }
    
    func instantiate() -> UIViewController {
        return instantiate(from: "Login")
    }
}
