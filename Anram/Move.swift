//
//  Move.swift
//  Anram
//
//  Created by Nelson Shaw on 8/08/15.
//  Copyright (c) 2015 Nelson Shaw. All rights reserved.
//

import Foundation
import ObjectMapper

class Move : Mappable{
    
    var date: String? //for now
    var player: User?
    var order: Int?
    var taken: Int?
    
    class func newInstance() -> Mappable {
        return Move()
    }
    
    
    func mapping(map: Map) {
        date <- map["date"]
        order <- map["order"]
        taken <- map["taken"]
        player <- map["player"]
    }
    
    
    init() {
        
    }
    
    required init?(_ map: Map) {
        mapping(map)
    }
    
}