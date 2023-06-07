//
//  GameManager.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/5/17.
//

import Foundation

class GameManager {
    
    public let _inputManager = InputManager.shared
    public let _dispatcher = Dispatcher()
    public let _statsManager = StatsManager.shared
    private var _characterMap: [UUID: Character] = [:]
    private var _operateCharacter: UUID? = nil
    public static let shared = GameManager()
    
    private init(){
        SetConnection()
    }
    public func SetConnection(network: Bool = false){
        if(network){
            _inputManager.OnDoPlayerAction += _dispatcher.sendAction
            _dispatcher.OnReceivePlayerAction += GivePlayerAction
        }else{
            _inputManager.OnDoPlayerAction += GivePlayerAction
            _inputManager.OnUpdatePlayerStats += GivePlayerStats
        }
    }
    
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
            print("Character not found")
            return
        }
        _operateCharacter = ID
        _inputManager.SetOperateCharacter(ID: ID)
    }
    
    public func GivePlayerAction(action: PlayerAction){
        print("GameManager: GivePlayerAction")
        guard let character = _characterMap[action.CharacterModelID] else {
            print("Character not found")
            return
        }
        character.DoAction(action: action)
    }
    
    public func GivePlayerStats(action: PlayerStats){
        print("GameManager: GivePlayerStats")
        guard let character = _characterMap[action.CharacterModelID] else {
            print("Character not found")
            return
        }
        _statsManager.UpdateStats(action: action)
        _statsManager.CheckHealth(action: action)
        
    }
    
    public func GiveGameEnding(winner: Character){
        //todo: complete it
        print("### Game Winner: \(winner.CharacterModelID)###")
    }
    
    //---
    //for testing
    public func GetCharacterMap() -> [UUID: Character]{
        return _characterMap
    }
}
