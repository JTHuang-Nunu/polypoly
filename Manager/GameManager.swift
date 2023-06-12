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
    public let OnCreatedSkillButtons = Event<[SkillSelectButton]>()
    public let OnCreatedCanvas = Event<Canvas>()
    public let OnCreatedEneryManager = Event<EnergyManager>()
    public let OnCreatedAllPlayers = Event<[UUID: Character]>()
    public let OnCreatedSelfPlayers = Event<[UUID: Character]>()
    public let OnCreatedOtherPlayers = Event<[UUID: Character]>()
    
    public let PlayerSkills: [Skill] = [.Move, .Obstacle]
    public let DefaultSkill = Skill.Move
    
    
    private let _inputManager = InputManager()
    private var _dispatcher: Dispatcher? = nil
    private var _skillManager: SkillManager? = nil
    private var _energyManager: EnergyManager? = nil
    
    private let logger = Logger(subsystem: "GameManager", category: "GameManager")
    private var _characterMap: [UUID: Character] = [:]
    private var _characterInfoMap: [UUID: CharacterInfo] = [:]
    private var _operateCharacter: UUID? = nil
    
    private let info: GameInfo
    
    
    init(info: GameInfo){
        self.info = info
        createDispatcher(deviceID: info.DeviceID, host: info.RoomInfo.RoomHostInfo)
    }
    public func CreateSceneObjects(){
        createSkillManager()
        createAllCharacter(characterMap: info.RoomInfo.PlayerInfoMap)
        createCanvas()
        createEnergyManager()
    }
    private func createDispatcher(deviceID: UUID, host: HostInfo){
        let sessionManager = ConnectionManager(hostInfo: host)
        _dispatcher = Dispatcher(deviceID: deviceID, sessionManager: sessionManager)
        _dispatcher!.OnConnected += OnConnectGameServer.Invoke
        SetConnection()
        OnConnectGameServer += {
            self._dispatcher?.sendJoinMessage()
        }
    }
    private func createEnergyManager(){
        _energyManager = EnergyManager(initValue: 1)
        OnCreatedEneryManager.Invoke(_energyManager!)
        _inputManager.SetEnergyManager(energyManager: _energyManager!)
    }
    private func createSkillManager(){
        _skillManager = SkillManager(skills: PlayerSkills)
        _skillManager!.OnSelectSkill += { skill in
            self._inputManager.SetSelectedSkill(skill: skill)
        }
        OnCreatedSkillButtons.Invoke(_skillManager!.skillButtons)
        _skillManager?.SetSkill(skill: DefaultSkill)
    }
    
    private func createCanvas(){
        let canvas = Canvas(startNode: GetOperateCharacter()!.SKNode)
        _inputManager.SetCanvas(canvas: canvas)
        OnCreatedCanvas.Invoke(canvas)
    }
    
    private func SetConnection(){
        _inputManager.OnDoPlayerAction += _dispatcher!.sendAction
        _dispatcher!.OnReceivePlayerAction += GivePlayerAction
    }
    
    public func GetOperateCharacter() -> Character?{
        if let character = GetCharacter(ID: _operateCharacter!){
            return character
        }
        logger.error("Operate character not found")
        return nil
        
    }
    
    private func createAllCharacter(characterMap: [String: CharacterInfo]){
        for (deviceID, playerInfo) in characterMap{
            CreateCharacter(info: playerInfo)
            if UUID(uuidString: deviceID) == DeviceManager.shared.DeviceID{
                SetOperateCharacter(ID: playerInfo.CharacterModelID)
            }
        }
        OnCreatedAllPlayers.Invoke(_characterMap)
        invokeSelfPlayers()
        invokeOtherPlayers()
    }
    
    private func invokeSelfPlayers(){
        var selfPlayers: [UUID: Character] = [:]
        for (ID, character) in _characterMap{
            if IfSameDirectionWithOperateCharacter(id: ID){
                selfPlayers[ID] = character
            }
        }
        OnCreatedSelfPlayers.Invoke(selfPlayers)
    }
    private func invokeOtherPlayers(){
        var otherPlayers: [UUID: Character] = [:]
        for (ID, character) in _characterMap{
            if !IfSameDirectionWithOperateCharacter(id: ID){
                otherPlayers[ID] = character
            }
        }
        OnCreatedOtherPlayers.Invoke(otherPlayers)
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
    
    private func GivePlayerAction(action: PlayerAction){
        guard let character = _characterMap[action.CharacterModelID] else {
            logger.error("Character not found")
            return
        }
        if IfSameDirectionWithOperateCharacter(id: action.CharacterModelID){
            character.DoAction(action: action)
        }else{
            character.DoAction(action: action.opposite)
        }
    }

    
    
    
    private func GetIfSameDirection(c1: Character, c2: Character) -> Bool{
        let team1 = GetCharacterInfo(ID: c1.CharacterModelID)?.TeamID
        let team2 = GetCharacterInfo(ID: c2.CharacterModelID)?.TeamID
        return team1 == team2
    }
    
    public func IfSameDirectionWithOperateCharacter(character: Character) -> Bool{
        return GetIfSameDirection(c1: GetOperateCharacter()!, c2: character)
    }
    public func IfSameDirectionWithOperateCharacter(id: UUID) -> Bool{
        return GetIfSameDirection(c1: GetOperateCharacter()!, c2: GetCharacter(ID: id)!)
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
