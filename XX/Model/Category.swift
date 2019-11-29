//
//  Category.swift
//  XX
//
//  Created by Seonghun Kim on 2019/11/03.
//  Copyright © 2019 YAPP. All rights reserved.
//

import Foundation
import RealmSwift
import RxRealm

class Category: Object {
    var id: Int = -1
    
    var name: String = ""
    var active: Bool = false
    var budget: Int = -1
    var period: Period?
    
    static func create(initValue: MondeyHelper.Category) -> Category {
        let category = Category()
        category.id = initValue.id
        category.name = initValue.title
        category.active = false
        category.budget = 0
        category.period = nil
        
        return category
    }
    
    #warning("임시 데이터를 위한 확장 기능")
    static func create(id: Int, budget: Int) -> Category {
        let category = Category()
        category.id = MondeyHelper.mondeyCategoryId[id-1]
        category.name = MondeyHelper.mondeyCategoryTitle[id-1]
        category.active = true
        category.budget = budget
        category.period = nil
        
        return category
    }
    
    var budgetString: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        return formatter.string(from: budget as NSNumber) ?? "0"
    }
    
    func update(budget: Int) {
        self.budget = budget
    }
    
    enum Period {
        case day
        case week
        case month
        case none
    }
    
    var title: String {
        guard 1...7 ~= id else { return "" }
        return MondeyHelper.mondeyCategoryTitle[id-1]
    }
    
    var subTitle: String {
        guard 1...7 ~= id else { return "" }
        return MondeyHelper.mondeyCategorySubTitle[id-1]
    }
}
