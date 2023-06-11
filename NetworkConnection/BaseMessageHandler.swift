//
//  BaseMessageHandler.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/6/5.
//

import Foundation

class BaseMessageHandler{
    public let OnConnected = Event<Void>()
    public let OnDisconnected = Event<Void>()
    
    public var sessionManager: ConnectionManager
    private let encoder: JSONEncoder = JSONEncoder()
    private let decoder: JSONDecoder = JSONDecoder()
    
    public var DeviceID: UUID
    init(deviceID: UUID, sessionManager: ConnectionManager){
        DeviceID = deviceID
        self.sessionManager = sessionManager
        self.sessionManager.OnReceiveData += handleReceiveMessage
        self.sessionManager.OnConnectionReady += handleOnConnected
        self.sessionManager.OnConnectionFailed += handleOnDisconnected
    
    }
    
    public func handleMessage(message: Message){
        if(message.DeviceID != DeviceID){
            print("Not my message")
        }
    }
    
    private func handleOnConnected(){
        OnConnected.Invoke(())
    }
    
    private func handleOnDisconnected(message: String){
        print("Disconnected: \(message)")
        OnDisconnected.Invoke(())
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
    
    
    public func sendMessage(message: Message){
        sessionManager.sendData(message: encodeJSON(message),reliable: true)
    }
}
