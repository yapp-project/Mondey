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
    let budget: Int
    let mount: Int
    
    init(budget: Int, mount: Int) {
        self.budget = budget
        self.mount = mount
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
}
