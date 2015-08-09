//
//  API.swift
//  Anram
//
//  Created by Nelson Shaw on 8/08/15.
//  Copyright (c) 2015 Nelson Shaw. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class API {
    static let baseURL = NSBundle.infoVar("BaseURL")!
    
    class var sharedInstance : API {
        struct Static {
            static let instance : API = API()
        }
        return Static.instance
    }
    
    
    func login(username: String, password: String, onComplete: ((user: User?, statusCode: Int?, error: NSError?) -> Void)) -> Void {
        
        let url = join("/", [API.baseURL, "login/"])
        var user: User? = nil
        let r = Alamofire.request(.POST, url, parameters: ["username": username, "password" : password], encoding: .JSON)
            .responseJSON
            {
                (request, response, data, error) in
                println(request)
                println(response)
                println(data)
                user = Mapper<User>().map(data)
                onComplete(user: user, statusCode: response?.statusCode, error: error)
                
        }
    }
    
    func signUp(username: String, password: String, onComplete: ((user: User?, statusCode: Int?, error: NSError?) -> Void)) -> Void {
        
        let url = join("/", [API.baseURL, "users/"])
        var user: User? = nil
        let r = Alamofire.request(.POST, url, parameters: ["username": username, "password" : password], encoding: .JSON)
            .responseJSON
            {
                (request, response, data, error) in
                println(request)
                println(response)
                println(data)
                user = Mapper<User>().map(data)
                onComplete(user: user, statusCode: response?.statusCode, error: error)
                
        }
    }
    
    func getGames(onComplete: ((games: Array<Game>?, statusCode: Int?, error: NSError?) -> Void)) -> Void {
        
        var gameResult: Array<Game>? = Array<Game>()
        let url = join("/", [API.baseURL, "games/"])
        let r = Alamofire.request(.GET, url, encoding: .JSON)
            .responseJSON
            {
                (request, response, data, error) in
                println(request)
                println(response)
                println(data)
                let result: Array<Game>? = Mapper<Game>().mapArray(data)
                if (result != nil){
                    gameResult = result
                }
                onComplete(games: gameResult!, statusCode: response?.statusCode, error: error)
            }
                
        }
    
    func getGame(gameId: Int, onComplete: ((game: Game?, statusCode: Int?, error: NSError?) -> Void)) -> Void {
        
        var gameResult: Game? = nil
        let url = join("/", [API.baseURL, "games", String(gameId)])
        let r = Alamofire.request(.GET, url, encoding: .JSON)
            .responseJSON
            {
                (request, response, data, error) in
                println(request)
                println(response)
                println(data)
                gameResult = Mapper<Game>().map(data)
                onComplete(game: gameResult!, statusCode: response?.statusCode, error: error)
        }
        
    }
    
    func createGame(counts: Array<Int>, onComplete: ((game: Game?, statusCode: Int?, error: NSError?) -> Void)) -> Void {
        
        var gameResult: Game? = nil
        let url = join("/", [API.baseURL, "games/"])
        
        let r = Alamofire.request(.POST, url, parameters: ["amounts" : counts], encoding: .JSON)
            .responseJSON
            {
                (request, response, data, error) in
                println(response)
                println(data)
                gameResult = Mapper<Game>().map(data)
                        
                onComplete(game: gameResult, statusCode: response?.statusCode, error: error)
        }
        
    }
    
    
    func makeMove(gameId: Int, pile: Int, taken: Int, onComplete: ((game: Game?, statusCode: Int?, error: NSError?) -> Void)) -> Void {
        
//        /game/{id}/move
//        {
//             pile : 0
//            taken : 5
//        }
        
        var gameResult: Game? = nil
        let url = join("/", [API.baseURL, "games", String(gameId), "move"])
        
        let r = Alamofire.request(.POST, url, parameters: ["pile" : pile, "taken" : taken], encoding: .JSON)
            .responseJSON
            {
                (request, response, data, error) in
                println(response)
                println(data)
                gameResult = Mapper<Game>().map(data)
                onComplete(game: gameResult, statusCode: response?.statusCode, error: error)
        }
        
    }
    
    func joinGame(gameId: Int, onComplete: ((game: Game?, statusCode: Int?, error: NSError?) -> Void)) -> Void {
        
        var gameResult: Game? = nil
        let url = join("/", [API.baseURL, "games", String(gameId), "join"])
        
        let r = Alamofire.request(.POST, url, encoding: .JSON)
            .responseJSON
            {
                (request, response, data, error) in
                println(response)
                println(data)
                gameResult = Mapper<Game>().map(data)
                onComplete(game: gameResult, statusCode: response?.statusCode, error: error)
        }
        
    }
    
}
