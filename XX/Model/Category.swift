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
    let id: Int
    
    var name: String
    var active: Bool
    var budget: Int
    var period: Period?
    
    init(initValue: MondeyHelper.Category) {
        self.id = initValue.id
        
        self.name = initValue.title
        self.active = false
        self.budget = 0
        self.period = nil
    }
    
    #warning("임시 데이터를 위한 확장 기능")
    init(id: Int, budget: Int) {
        self.id = MondeyHelper.mondeyCategoryId[id-1]
        
        self.name = MondeyHelper.mondeyCategoryTitle[id-1]
        self.active = true
        self.budget = budget
        self.period = nil
    }
    
    required init() {
        fatalError("init() has not been implemented")
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
