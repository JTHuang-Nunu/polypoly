//
//  Dispacher.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/5/15.
//
//  Dispacher is a class that dispaches player actions to other device by SessionManager
import Foundation
class Dispatcher {
    public let OnReceivePlayerAction = Event<PlayerAction>()
    
    
    private var sessionManager: SesstionManager = SesstionManager.shared
    private let encoder: JSONEncoder = JSONEncoder()
    private let decoder: JSONDecoder = JSONDecoder()
    
    private var DeviceID: UUID
    init(){
        DeviceID = UUID()
        sessionManager.OnReceiveData += handleReceiveMessage
    }
    
    public func RequestRoom(){
        let message = Message(DeviceID: DeviceID, MessageType: .RequestRoom)
        sendMessage(message: message)
    }
    
    public func sendAction(action: PlayerAction){
        let data = Message(DeviceID: DeviceID, MessageType: .PlayerAction, Content: encodeJSON(message: action))
        sendMessage(message: data)
    }
    
    private func handleMessage(message: Message){
        
        if(message.DeviceID != DeviceID){
            print("Not my message")
        }
        
        
        switch message.MessageType {
        case .RequestRoom:
            break
        case .PlayerAction:
            handleReceivePlayerAction(content: message.Content)
            break
        case .CreateRoom:
            print("CreateRoom")
            break
        default:
            break
        }
    }
    
    private func handleReceivePlayerAction(content: String){
        let decodedAction = decodeJSON(PlayerAction.self, jsonString: content)
        if let action = decodedAction{
            OnReceivePlayerAction.Invoke(action)
        }
        else{
            print("Error: Receive invalid player action")
        }
    }
    
    private func handleReceiveMessage(content: String){
        let decodedMessage = decodeJSON(Message.self, jsonString: content)
        if let message = decodedMessage{
            handleMessage(message: message)
        }
        else{
            print("Error: Receive invalid message")
        
        }
    }
    
    
    private func sendMessage(message: Message){
        sessionManager.sendData(message: encodeJSON(message: message),reliable: true)
    }
    

    private func decodeJSON<T: Codable>(_ type: T.Type, jsonString: String)->T?{
        do{
            let jsonData = jsonString.data(using: .utf8)!
            let message = try decoder.decode(T.self, from: jsonData)
            return message
        }catch{
            print(error)
        }
        return nil
    
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
