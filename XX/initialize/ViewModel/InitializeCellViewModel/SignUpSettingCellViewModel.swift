//
//  InitializeCellViewModel.swift
//  XX
//
//  Created by Seonghun Kim on 2019/11/02.
//  Copyright © 2019 YAPP. All rights reserved.
//

import Foundation

class SignUpSettingCellViewModel: NSObject {
    let category = BehaviorRelay<Category>(value: .init())
    
    func decimal(int: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        return formatter.string(from: int as NSNumber) ?? ""
    }
    
    func stringToInt(_ string: String) -> Int {
        let pureIntString = string.components(separatedBy: ",").joined()
        
        return Int(pureIntString) ?? 0
    }
}
