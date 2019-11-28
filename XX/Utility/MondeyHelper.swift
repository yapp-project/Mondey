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
        mondeyCategoryId
            .map {
                Category(id: $0, title: mondeyCategoryTitle[$0 - 1], SubTitle: mondeyCategorySubTitle[$0 - 1])
                
    }
    
    struct Category {
        let id: Int
        let title: String
        let SubTitle: String
    }
}
