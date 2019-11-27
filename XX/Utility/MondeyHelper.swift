//
//  MondeyHelper.swift
//  XX
//
//  Created by 박은비 on 27/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import UIKit

class MondeyHelper: NSObject {
    static let mondeyCategoryId = [1, 2, 3, 4, 5, 6, 7]
    
    static let mondeyCategoryTitle = [
        "식비",
        "쇼핑",
        "미용/운동",
        "교통, 자동차",
        "여가/취미",
        "고정비",
        "기타"
    ]
    
    static let mondeyCategoryTitleColor = [
        UIColor.init(displayP3Red: 255/255, green: 224/255, blue: 95/255, alpha: 1), //식비
        UIColor.init(displayP3Red: 255/255, green: 88/255, blue: 70/255, alpha: 1),  //쇼핑
        UIColor.init(displayP3Red: 255/255, green: 224/255, blue: 95/255, alpha: 1), //미용/운동
        UIColor.init(displayP3Red: 255/255, green: 224/255, blue: 95/255, alpha: 1), //교통, 자동차
        UIColor.init(displayP3Red: 255/255, green: 224/255, blue: 95/255, alpha: 1), //여가/취미
        UIColor.init(displayP3Red: 255/255, green: 224/255, blue: 95/255, alpha: 1), //고정비
        UIColor.init(displayP3Red: 142/255, green: 237/255, blue: 193/255, alpha: 1) //기타
    ]
    
    static let mondeyCategorySubTitle = [
        "식사, 외식, 카페, 술, 장보기등",
        "패션, 인터넷쇼핑등",
        "건강, 헤어, 메이크업등",
        "교통비, 자동차 비용등",
        "여가, 취미, 문화생할등",
        "경조사, 보험금, 공과금등",
        "적금, 애완동물등"
    ]
    

    static let mondeyCategory =
        mondeyCategoryId.map { Category(id: $0,
                                        tintColor: mondeyCategoryTitleColor[$0 - 1],
                                        title: mondeyCategoryTitle[$0 - 1],
                                        SubTitle: mondeyCategorySubTitle[$0 - 1]) }
    
    struct Category {
        let id: Int
        let tintColor: UIColor
        let title: String
        let SubTitle: String
    }
    
    
    // 가장 최상위 뷰가져오기
    static func getTopViewController() -> UIViewController {
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            
            return topController
        }
        
        return UIViewController.init()
    }
    
}


extension UIAlertController {
    
    /// `UIAlertController` Helper.
    static func alert(title: String?,
                      message: String?,
                      style: UIAlertController.Style = .alert) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        return alert
    }
    
    /// `UIAlertAction` Helper.
    @discardableResult
    func action(title: String?,
                style: UIAlertAction.Style = .default,
                completion: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        let action = UIAlertAction(title: title, style: style) { completion?($0) }
        addAction(action)
        return self
    }
    
    /// 빌더 패턴을 통해 만들어진 `UIAlertController` present.
    func present(to viewController: UIViewController?,
                 animated: Bool = true,
                 completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            if !(viewController?.presentedViewController is UIAlertController) {
                viewController?.present(self, animated: animated, completion: completion)
            }
        }
    }
}

