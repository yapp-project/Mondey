//
//  Expenditure.swift
//  XX
//
//  Created by Seonghun Kim on 2019/11/17.
//  Copyright © 2019 YAPP. All rights reserved.
//

import Foundation
import RealmSwift
import RxRealm

class Expenditure: Object {
    var id: Int = -1
    var desc: String = ""
    var cost: Int = -1
    var date: Date = Date()
    
    static func create(id: Int, desc: String, cost: Int, date: String) -> Expenditure {
        let expend = Expenditure()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        expend.id = id
        expend.desc = desc
        expend.cost = cost
        expend.date = formatter.date(from: date) ?? Date()
        
        return expend
    }
}
