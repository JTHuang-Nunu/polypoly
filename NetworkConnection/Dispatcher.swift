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
    private var decoder: JSONDecoder
    private var PlayerID: UUID
    init(){
        sessionManager = SesstionManager(ip: "localhost", port: 8000)
        
        encoder = JSONEncoder()
        decoder = JSONDecoder()
        PlayerID = UUID()
        sessionManager.OnReceiveData += { str in
            let message = self.decodeJSON(jsonString: str)
            self.handleMessage(message: message)
        }
        
    }
    
    public func RequestRoom(){
        let data = Message(PlayerID: PlayerID, MessageType: .RequestRoom)
        sessionManager.sendData(message: encodeJSON(message: data),reliable: true)
    }
    
    public func sendAction(action: PlayerAction){
        let data = Message(PlayerID: PlayerID, MessageType: .PlayerAction, Content: encodeJSON(message: action))
        sessionManager.sendData(message: encodeJSON(message: data),reliable: true)
    }
    
    private func handleMessage(message: Message){
        
        if(message.PlayerID != PlayerID){
            print("Not my message")
        }
        
        
        switch message.MessageType {
        case .RequestRoom:
            break
        case .PlayerAction:
            print("Receive PlayerAction")
            break
        case .CreateRoom:
            print("CreateRoom")
            break
        default:
            break
        }
    }
    private func decodeJSON(jsonString: String)->Message{
        do{
            let jsonData = jsonString.data(using: .utf8)!
            let message = try decoder.decode(Message.self, from: jsonData)
            return message
        }catch{
            print(error)
        }
        return Message(PlayerID: UUID(), MessageType: .CancelRequest)
    
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
