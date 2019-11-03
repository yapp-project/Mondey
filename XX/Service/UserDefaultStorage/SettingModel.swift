//
//  SettingModel.swift
//  XX
//
//  Created by Seonghun Kim on 2019/11/02.
//  Copyright © 2019 YAPP. All rights reserved.
//

import Foundation

struct SettingModel {
    let categories: [Category]
    
    init(initValue: [MondeyHelper.Category]) {
        self.categories = initValue.map {
            Category(initValue: $0)
        }
    }
}


