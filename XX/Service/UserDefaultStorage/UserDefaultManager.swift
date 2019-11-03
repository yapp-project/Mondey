//
//  UserInfoManager.swift
//  XX
//
//  Created by Seonghun Kim on 2019/11/02.
//  Copyright © 2019 YAPP. All rights reserved.
//

import Foundation

class UserDefaultManager {
    static var token: String? {
        get {
            return UserDefaults.standard.string(forKey: "token")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "token")
        }
    }
    
    static var budget: Int {
        get {
            return UserDefaults.standard.integer(forKey: "budget")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "budget")
        }
    }
}
