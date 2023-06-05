//
//  DeviceManager.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/6/5.
//

import Foundation

class DeviceManager{
    public static let shared = DeviceManager()
    
    public let DeviceID = UUID()
    
    public var _lobbyManager: LobbyManager? = nil
    public var _gameManager: GameManager? = nil
    
    private var _lobbyPeer: ConnectionManager? = nil
    private var _gamePeer: ConnectionManager? = nil
    
    private let _lobbyHostInfo = HostInfo(IP: "localhost", Port: 8000)
    private var _gameHostInfo: HostInfo? = nil
    
    
    private init()
    {
        _lobbyPeer = ConnectionManager(hostInfo: _lobbyHostInfo)
    }
    
    public func EnterLobby(){
        _lobbyManager = LobbyManager(deviceID: DeviceID, sessionManager: _lobbyPeer!)
        _lobbyManager!.OnCreateRoom += createRoom
    }
    
    public func LeaveLobby(){
        
    }
    public func EnterWaitPlayer(){
        
    }
    public func EnterRoom(){
        
    }
    public func LeaveRoom(){
        
    }
    
    
    
    private func createRoom(roomInfo: RoomInfo){
        self._gameHostInfo = roomInfo.RoomHostInfo
        self._gamePeer = ConnectionManager(hostInfo: self._gameHostInfo!)
        self._gameManager = GameManager(deviceID: self.DeviceID, sessionManager: self._gamePeer!)
    }
}
