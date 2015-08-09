//
//  Pile.swift
//  Anram
//
//  Created by Nelson Shaw on 8/08/15.
//  Copyright (c) 2015 Nelson Shaw. All rights reserved.
//

import Foundation
import ObjectMapper

class Pile : Mappable{
    
    var position: Int?
    var amount: Int?
    
    class func newInstance() -> Mappable {
        return Pile()
    }
    
    func mapping(map: Map) {
        position <- map["position"]
        amount <- map["amount"]
    }
    
    init() {
        
    }
    
    required init?(_ map: Map) {
        mapping(map)
    }
}