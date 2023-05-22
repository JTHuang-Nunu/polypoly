//
//  Dispacher.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/5/15.
//
//  Dispacher is a class that dispaches player actions to other device by SessionManager
import Foundation
class Dispatcher{
    private enum RequestType: String{
        case RequestRoom
        case CancelRequest
        case PlayerAction
        case PlayerLeave
    }
    private var sessionManager: SesstionManager
    private var encoder: JSONEncoder
    
    init(){
        sessionManager = SesstionManager(ip: "172.20.10.5", port: 8000)
        sessionManager.setReceiveDataHandler{ str in
            print(str)
        }
        encoder = JSONEncoder()
    }
    
    public func RequestRoom(playerID: UUID){
        let request: RequestType = .RequestRoom
        let data: [String: String] = ["PlayerID" : playerID.uuidString,
                                      "RequestType" : request.rawValue]
        
        sessionManager.sendData(message: encodeJSON(message: data),reliable: true)
    }
    
    private func sendAction(PlayerID: UUID, action: PlayerAction){
        let request: RequestType = .PlayerAction
        let data: [String: String] = ["PlayerID" : PlayerID.uuidString,
                                      "RequestType" : request.rawValue,
                                      "Action" : encodeJSON(message: action)]
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
