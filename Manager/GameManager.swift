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
    public var _dispatcher: Dispatcher? = nil
    public var _skillManager: SkillManager? = nil
    
    private let logger = Logger(subsystem: "GameManager", category: "GameManager")
    private var _characterMap: [UUID: Character] = [:]
    private var _characterInfoMap: [UUID: CharacterInfo] = [:]
    private var _operateCharacter: UUID? = nil
    
    init(info: GameInfo){
        if(info.UseServer){
            let sessionManager = ConnectionManager(hostInfo: info.RoomInfo.RoomHostInfo)
            _dispatcher = Dispatcher(deviceID: info.DeviceID, sessionManager: sessionManager)
            _dispatcher!.OnConnected += OnConnectGameServer.Invoke
        }
        _skillManager = SkillManager(skills: [.Move])
        SetConnection(network: info.UseServer)
        _skillManager?.OnSelectSkill += { skill in
            self._inputManager.SetSelectedSkill(skill: skill)
        }
        CreateAllCharacter(characterMap: info.RoomInfo.PlayerInfoMap)
        OnConnectGameServer += {
            self._dispatcher?.sendJoinMessage()
        }
    }
    private func SetConnection(network: Bool = false){
        if(network){
            _inputManager.OnDoPlayerAction += _dispatcher!.sendAction
            _dispatcher!.OnReceivePlayerAction += GivePlayerAction
        }else{
            _inputManager.OnDoPlayerAction += GivePlayerAction
        }
    }
    
    public func GetOperateCharacter() -> Character?{
        if let character = GetCharacter(ID: _operateCharacter!){
            return character
        }
        logger.error("Operate character not found")
        return nil
        
    }
    
    private func CreateAllCharacter(characterMap: [String: CharacterInfo]){
        for (deviceID, playerInfo) in characterMap{
            CreateCharacter(info: playerInfo)
            if UUID(uuidString: deviceID) == DeviceManager.shared.DeviceID{
                SetOperateCharacter(ID: playerInfo.CharacterModelID)
            }
        }
    }
    public func GetCharacter(ID: UUID) -> Character?{
        return _characterMap[ID]
    }
    public func GetCharacterInfo(ID: UUID) -> CharacterInfo?{
        return _characterInfoMap[ID]
    }
    
    private func CreateCharacter(info: CharacterInfo){
        let character = CharacterFactory.shared.createCharacter(ID: info.CharacterModelID)
        _characterMap[info.CharacterModelID] = character
        _characterInfoMap[info.CharacterModelID] = info
    }
    
    private func SetOperateCharacter(ID: UUID){
        guard _characterMap[ID] != nil else {
            logger.error("Character not found")
            return
        }
        _operateCharacter = ID
        _inputManager.SetOperateCharacter(ID: ID)
    }
    
    public func GivePlayerAction(action: PlayerAction){
        logger.info("Give player action")
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
struct GameInfo{
    let DeviceID: UUID
    let RoomInfo: RoomInfo
    let UseServer: Bool
}
