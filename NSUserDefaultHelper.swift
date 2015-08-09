//
//  NSUserDefaultHelper.swift
//  Anram
//
//  Created by Nelson Shaw on 9/08/15.
//  Copyright (c) 2015 Nelson Shaw. All rights reserved.
//

import Foundation
import CoreLocation

class UserStore {
    enum StoreKeys: String {
        case UserName = "userName"
    }
    static let get = NSUserDefaults.standardUserDefaults().objectForKey
    static let set = NSUserDefaults.standardUserDefaults().setObject
    
    class var userName: String? {
        get {
        return get(StoreKeys.UserName.rawValue) as? String
        }
        set {
            set(newValue, forKey: StoreKeys.UserName.rawValue)
        }
    }
    
}