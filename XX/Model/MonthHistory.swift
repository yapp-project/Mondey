//
//  MonthHistory.swift
//  XX
//
//  Created by Seonghun Kim on 2019/11/17.
//  Copyright © 2019 YAPP. All rights reserved.
//

import Foundation
//import RealmSwift
//import RxRealm

struct MonthHistory {
    let budget: Int
    let mount: Int
    
    init(budget: Int, mount: Int) {
        self.budget = budget
        self.mount = mount
    }
}
