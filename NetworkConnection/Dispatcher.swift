//
//  Dispacher.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/5/15.
//
//  Dispacher is a class that dispaches player actions to other device by SessionManager
import Foundation
import os

class Dispatcher: BaseMessageHandler {
    public let OnReceivePlayerAction = Event<PlayerAction>()
    private let logger = Logger(subsystem: "Dispatcher", category: "Dispatcher")
    
    override init(deviceID: UUID, sessionManager: ConnectionManager){
        super.init(deviceID: deviceID, sessionManager: sessionManager)
    }
    
    public func sendAction(action: PlayerAction){
        let data = Message(DeviceID: DeviceID, MessageType: .PlayerAction, Content: encodeJSON(action))
        sendMessage(message: data)
    }
    public func sendJoinMessage(){
        let data = Message(DeviceID: DeviceID, MessageType: .JoinMessage)
        sendMessage(message: data)
    }
    
    override func handleMessage(message: Message){
        super.handleMessage(message: message)

        switch message.MessageType {
        case .PlayerAction:
            handleReceivePlayerAction(content: message.Content)
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
            logger.error("Failed to decode PlayerAction")
        }
    }
}
