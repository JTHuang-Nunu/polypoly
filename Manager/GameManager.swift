//
//  GameManager.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/5/17.
//

import Foundation
import os

/// GameManager是一個管理遊戲的class，包含了所有遊戲的角色，網路連接
class GameManager {
    
    public let OnConnectGameServer = Event<Void>()
    
    public let _inputManager = InputManager()
    public var _dispatcher: Dispatcher
    
    private let logger = Logger(subsystem: "GameManager", category: "GameManager")
    private var _characterMap: [UUID: Character] = [:]
    private var _operateCharacter: UUID? = nil
    
    /// 這是GameManager的宣告
    /// - Parameters:
    ///   - deviceID: 裝置ID, 通常在DeviceManager會設定好
    ///   - sessionManager: 給Dispatcher傳輸用的，如果不需要使用GameServer，可以傳入nil
    ///   - useGameServer: 是否使用GameServer，預設為true
    init(deviceID: UUID, sessionManager: ConnectionManager, useGameServer: Bool = true){
        _dispatcher = Dispatcher(deviceID: deviceID, sessionManager: sessionManager)
        _dispatcher.OnConnected += OnConnectGameServer.Invoke
        SetConnection(network: useGameServer)
    }
    private func SetConnection(network: Bool = false){
        if(network){
            _inputManager.OnDoPlayerAction += _dispatcher.sendAction
            _dispatcher.OnReceivePlayerAction += GivePlayerAction
        }else{
            _inputManager.OnDoPlayerAction += GivePlayerAction
        }
    }
    
    /// 使用玩家ID來取得玩家角色Character物件
    /// - Parameter ID: 玩家ID
    /// - Returns: 玩家角色Character物件
    public func GetCharacter(ID: UUID) -> Character?{
        return _characterMap[ID]
    }
    
    public func CreateCharacter(ID: UUID) -> Character{
        let character = CharacterFactory.shared.createCharacter(ID: ID)
        _characterMap[ID] = character
        return character
    }
    
    public func SetOperateCharacter(ID: UUID){
        guard _characterMap[ID] != nil else {
            logger.error("Character not found")
            return
        }
        _operateCharacter = ID
        _inputManager.SetOperateCharacter(ID: ID)
    }
    
    public func GivePlayerAction(action: PlayerAction){
        guard let character = _characterMap[action.CharacterModelID] else {
            logger.error("Character not found")
            return
        }
        character.DoAction(action: action)
    }
    
    //---
    //for testing
    public func GetCharacterMap() -> [UUID: Character]{
        return _characterMap
    }
}
