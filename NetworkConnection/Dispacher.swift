//
//  Dispacher.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/5/15.
//
//  Dispacher is a class that dispaches player actions to other device by SessionManager
import Foundation
class Dispacher{
    
    private var sessionManager: SesstionManager
    private var encoder: JSONEncoder
    
    init(){
        sessionManager = SesstionManager(ip: "172.20.10.5", port: 8000)
        encoder = JSONEncoder()
    }
    
    public func InputAction(action: PlayerAction){
        sendAction(action: action)
    
        
    }
    
    private func sendAction(action: PlayerAction){
        var data: String = ""
        do{
            let jsonData = try encoder.encode(action)
            data = String(data: jsonData, encoding: .utf8)!
        }
        catch{
            print(error)
        }
        var outputMessage = ["type" : "PlayerAction",
                            "content" : data
        ]
        
        do{
            let jsonData = try encoder.encode(outputMessage)
            let jsonString = String(data: jsonData, encoding: .utf8)!
            sessionManager.sendData(message: jsonString)
        }
        catch{
            print(error)
        }
    }
    
    
    
    
    
    
    
}
