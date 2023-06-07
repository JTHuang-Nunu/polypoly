//
//  LobbyManager.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/6/5.
//

import Foundation

class LobbyManager: BaseMessageHandler{
    public let OnCreateRoom = Event<RoomInfo>()
    public let OnConnectLobby = Event<Void>()
    init(info: LobbyInfo){
        let sessionManager = ConnectionManager(hostInfo: info.LobbyHostInfo)
        super.init(deviceID: info.DeviceID, sessionManager: sessionManager)
        self.sessionManager.OnConnectionReady += OnConnectLobby.Invoke
    }
    override func handleMessage(message: Message) {
        super.handleMessage(message: message)
        switch message.MessageType {
        case .CreateRoom:
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
        let message = Message(DeviceID: DeviceID, MessageType: .RequestRoom)
        sendMessage(message: message)
    }
    
    public func LeaveLobby(){
        sessionManager.Cancel()
    }
}
struct LobbyInfo{
    let DeviceID: UUID
    let LobbyHostInfo: HostInfo
}
