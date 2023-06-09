//
//  DeviceManager.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/6/5.
//

import Foundation
import GameplayKit
import os

class DeviceManager{
    public static let shared = DeviceManager()
    
    public let OnEnterLobby = Event<Void>()
    public let OnEnterGame = Event<Void>()
    public let OnStartWaitingRoom = Event<Void>()
    
    public let DeviceID = UUID()
    
    public let logger = Logger(subsystem: "DeviceManager", category: "DeviceManager")
    
    private var _lobbyManager: LobbyManager? = nil
    private var _gameManager: GameManager? = nil
    
    private let _lobbyHostInfo = HostInfo(IP: HostIP, Port: 8000)
//    private let _lobbyHostInfo = HostInfo(IP: "localhost", Port: 8000)
    private var _gameHostInfo: HostInfo? = nil
    
    private var stateMachine: GKStateMachine? = nil
    
    public func Initialize(){
        stateMachine!.enter(NoConnectionState.self)
    }
    
    private func createLobbyManager(lobbyHost: HostInfo) -> LobbyManager{
        let info = LobbyInfo(DeviceID: DeviceID, LobbyHostInfo: lobbyHost)
        _lobbyManager = polypoly.LobbyManager(info: info)
        return _lobbyManager!
    }
    private func createLobbyManager() -> LobbyManager{
        return createLobbyManager(lobbyHost: _lobbyHostInfo)
    }

    private func createRoom(roomInfo: RoomInfo){
        let info = GameInfo(DeviceID: DeviceID, RoomInfo: roomInfo, UseServer: true)
        _gameManager = polypoly.GameManager(info: info)
    }
    private init(){
        stateMachine = GKStateMachine(states: [
            NoConnectionState(deviceManager: self),
            LobbyState(deviceManager: self),
            WaitRoomState(deviceManager: self),
            GameState(deviceManager: self)
        ])
    
    }
    
    public func RequestRoom(){
        if stateMachine?.currentState is LobbyState{
            _lobbyManager?.RequestRoom()
            stateMachine?.enter(WaitRoomState.self)
        }
        else{
            logger.error("Device is not in lobby")
        }
    }
    
    
    
    public var LobbyManager: LobbyManager?{
        get{
            if _lobbyManager == nil{
                print("Device is not in lobby")
            }
            
            return _lobbyManager
        }
    }
    
    
    public var GameManager: GameManager?{
        get{
            if _gameManager == nil{
                print("Device is not in game")
            }
            
            return _gameManager
        }
    }
    private class DeviceState: GKState{
        unowned let DeviceManager: DeviceManager
        init(deviceManager: DeviceManager){
            DeviceManager = deviceManager
        }
    }
    private class NoConnectionState: DeviceState{
        override func didEnter(from previousState: GKState?) {
            DeviceManager.logger.log("Enter No Connection State")
            
            let lobby = DeviceManager.createLobbyManager()
            lobby.OnConnectLobby += {
                self.stateMachine?.enter(LobbyState.self)
            }
            
        }

    }

    private class LobbyState: DeviceState{
        override func didEnter(from previousState: GKState?) {
            DeviceManager.OnEnterLobby.Invoke(())
            
            DeviceManager.logger.log("Enter Lobby State")
        
        }
    }
    private class WaitRoomState: DeviceState{
        override func didEnter(from previousState: GKState?) {
            DeviceManager.OnStartWaitingRoom.Invoke(())
            DeviceManager.logger.log("Enter Wait Room State")
            DeviceManager.LobbyManager?.OnCreateRoom += { roomInfo in
                self.DeviceManager.logger.log("Create Room")
                self.DeviceManager.createRoom(roomInfo: roomInfo)
                self.DeviceManager.GameManager?.OnConnectGameServer += {
                    self.stateMachine?.enter(GameState.self)
                }
                self.DeviceManager.GameManager?.OnWin += {
                    self.stateMachine?.enter(LobbyState.self)
                }
                self.DeviceManager.GameManager?.OnLose += {
                    self.stateMachine?.enter(LobbyState.self)
                }
            }
        }


    }
    private class GameState: DeviceState{
        override func didEnter(from previousState: GKState?) {
            DeviceManager.OnEnterGame.Invoke(())
            DeviceManager.logger.log("Enter Game State")
            
        }

    }

    
}

