//
//  Game.swift
//  Anram
//
//  Created by Nelson Shaw on 8/08/15.
//  Copyright (c) 2015 Nelson Shaw. All rights reserved.
//

import Foundation
import ObjectMapper

class Game : Mappable {
    
    var status: String?
    var players: [User]?
    var moves: [Move]?
    var id: Int?
    var piles: [Pile]?
    
    
    
    class func newInstance() -> Mappable {
        return Game()
    }
    
    
    func mapping(map: Map) {
        id <- map["id"]
        status <- map["status"]
        players <- map["players"]
        moves <- map["moves"]
        piles <- map["piles"]
        
    }
    
    func getRemainingAmounts() -> Int{
        var sum: Int = 0
        for pile in piles!{
            sum += pile.amount!
        }
        return sum
    }
    
    init() {
        
    }
    
    required init?(_ map: Map) {
        mapping(map)
    }
   
    
    
}