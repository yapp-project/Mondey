//
//  Category.swift
//  XX
//
//  Created by Seonghun Kim on 2019/11/03.
//  Copyright © 2019 YAPP. All rights reserved.
//

import Foundation

struct Category {
    let id: Int
    let title: String
    let subTitle: String
    var active: Bool
    var budget: Int
    var period: Period?
    
    init(initValue: MondeyHelper.Category) {
        self.id = initValue.id
        self.title = initValue.title
        self.subTitle = initValue.SubTitle
        self.active = false
        self.budget = 0
        self.period = nil
    }
    
    init() {
        self.id = -1
        self.title = ""
        self.subTitle = ""
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
