//
//  Dispacher.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/5/15.
//
//  Dispacher is a class that dispaches player actions to other device by SessionManager
import Foundation
class Dispatcher{
    private var sessionManager: SesstionManager
    private var encoder: JSONEncoder
    
    init(){
        sessionManager = SesstionManager(ip: "localhost", port: 8000)
        encoder = JSONEncoder()
    }
    
    public func RequestRoom(playerID: UUID){
        let data = Message(PlayerID: playerID, MessageType: .RequestRoom)
        sessionManager.sendData(message: encodeJSON(message: data),reliable: true)
    }
    
    private func sendAction(PlayerID: UUID, action: PlayerAction){
        let data = Message(PlayerID: PlayerID, MessageType: .PlayerAction, Content: encodeJSON(message: action))
        sessionManager.sendData(message: encodeJSON(message: data),reliable: true)
    }
    private func encodeJSON(message: Codable)-> String{
        do{
            let jsonData = try encoder.encode(message)
            return String(data: jsonData, encoding: .utf8)!
        }catch{
            print(error)
        }
        return ""
    }
}
