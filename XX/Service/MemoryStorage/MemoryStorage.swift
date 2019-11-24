//
//  MemoryStorage.swift
//  XX
//
//  Created by Seonghun Kim on 06/10/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import Foundation

class MemoryStorage {
    var categories = TempData.categories
    var expenditure = TempData.expenditure
    var monthHistory = TempData.monthHistory
}

extension MemoryStorage: StorageType {
    
}
