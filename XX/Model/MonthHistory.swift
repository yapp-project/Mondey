//
//  MonthHistory.swift
//  XX
//
//  Created by Seonghun Kim on 2019/11/17.
//  Copyright © 2019 YAPP. All rights reserved.
//

import Foundation
import RealmSwift
import RxRealm

class MonthHistory: Object {
    var budget: Int = -1
    var mount: Int = -1
    
    static func create(budget: Int, mount: Int) -> MonthHistory {
        let history = MonthHistory()
        history.budget = budget
        history.mount = mount
        
        return history
    }
}
