//
//  Dispacher.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/5/15.
//
//  Dispacher is a class that dispaches player actions to other device by SessionManager
import Foundation
class Dispatcher: BaseMessageHandler {
    public let OnReceivePlayerAction = Event<PlayerAction>()

    override init(deviceID: UUID, sessionManager: ConnectionManager){
        super.init(deviceID: deviceID, sessionManager: sessionManager)
    }
    
    public func sendAction(action: PlayerAction){
        let data = Message(DeviceID: DeviceID, MessageType: .PlayerAction, Content: encodeJSON(message: action))
        sendMessage(message: data)
    }
    
    override func handleMessage(message: Message){
        print("Dispatcher: Handle message")
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
        print("Receive playeraction")
        let decodedAction = decodeJSON(PlayerAction.self, jsonString: content)
        if let action = decodedAction{
            OnReceivePlayerAction.Invoke(action)
        }
        else{
            print("Error: Receive invalid player action")
        }
    }
}
