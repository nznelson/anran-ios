//
//  User.swift
//  Anram
//
//  Created by Nelson Shaw on 8/08/15.
//  Copyright (c) 2015 Nelson Shaw. All rights reserved.
//

import Foundation
import ObjectMapper

class User : Mappable {

    var username: String?
    
    class func newInstance() -> Mappable {
        return User()
    }
    
    init() {
    }
    
    required init?(_ map: Map) {
        mapping(map)
    }
    
    func mapping(map: Map) {
        username <- map["username"]
    }
}