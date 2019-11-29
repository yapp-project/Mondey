//
//  Category.swift
//  XX
//
//  Created by Seonghun Kim on 2019/11/03.
//  Copyright © 2019 YAPP. All rights reserved.
//

import Foundation

struct Category {
    var id: Int
    var tintColor: UIColor
    var title: String
    var subTitle: String
    
    var name: String
    var active: Bool
    var budget: Int
    var period: Period?
    
    init(initValue: MondeyHelper.Category) {
        self.id = initValue.id
        self.tintColor = initValue.tintColor
        self.title = initValue.title
        self.subTitle = initValue.SubTitle
        
        self.name = initValue.title
        self.active = false
        self.budget = 0
        self.period = nil
    }
    
    init() {
        self.id = -1
        self.tintColor = UIColor.black
        self.title = ""
        self.subTitle = ""
        
        self.name = ""
        self.active = false
        self.budget = 0
        self.period = nil
    }
    
    var budgetString: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        return formatter.string(from: budget as NSNumber) ?? "0"
    }
    
    mutating func update(budget: Int) {
        self.budget = budget
    }
    
    enum Period {
        case day
        case week
        case month
        case none
    }
}

#warning("임시 데이터를 위한 확장 기능")
extension Category {
    
    init(id: Int, budget: Int) {
        self.id = MondeyHelper.mondeyCategoryId[id-1]
        self.tintColor = MondeyHelper.mondeyCategoryTitleColor[id-1]
        self.title = MondeyHelper.mondeyCategoryTitle[id-1]
        self.subTitle = MondeyHelper.mondeyCategorySubTitle[id-1]
        
        self.name = MondeyHelper.mondeyCategoryTitle[id-1]
        self.active = true
        self.budget = budget
        self.period = nil
    }
}
