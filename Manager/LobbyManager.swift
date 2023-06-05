//
//  LobbyManager.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/6/5.
//

import Foundation

class LobbyManager: BaseMessageHandler{
    public let OnCreateRoom = Event<RoomInfo>()
    override init(deviceID: UUID, sessionManager: ConnectionManager){
        super.init(deviceID: deviceID, sessionManager: sessionManager)
    }
    override func handleMessage(message: Message) {
        super.handleMessage(message: message)
        switch message.MessageType {
        case .CreateRoom:
            print("Create Room")
            handleReceiveCreateRoom(content: message.Content)
            break
        default:
            break
        }
    }
    
    private func handleReceiveCreateRoom(content: String){
        let roomInfo = decodeJSON(RoomInfo.self, jsonString: content)
        if let roomInfo = roomInfo{
            OnCreateRoom.Invoke(roomInfo)
        }
        else{
            print("Error: Receive invalid room info")
        }
    }
    
    
    
    public func RequestRoom(){
        print("Request Room")
        let message = Message(DeviceID: DeviceID, MessageType: .RequestRoom)
        sendMessage(message: message)
    }
}
