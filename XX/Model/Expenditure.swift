//
//  Expenditure.swift
//  XX
//
//  Created by Seonghun Kim on 2019/11/17.
//  Copyright © 2019 YAPP. All rights reserved.
//

import Foundation

struct Expenditure {
    let id: Int
    let desc: String
    let cost: Int
    let date: Date
}

extension Expenditure {
    
    
    init(id: Int, desc: String, cost: Int, date: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        self.id = id
        self.desc = desc
        self.cost = cost
        self.date = formatter.date(from: date) ?? Date()
    }
}
