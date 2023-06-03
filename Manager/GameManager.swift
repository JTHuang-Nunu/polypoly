//
//  GameManager.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/5/17.
//

import Foundation

class GameManager {
    
    public let inputManager = InputManager.shared
    public let _dispatcher = Dispatcher()
    
    
    private var _characterMap: [UUID: Character] = [:]
    private var _operateCharacter: UUID? = nil
    public static let shared = GameManager()
    
    private init(){
        inputManager.OnDoPlayerAction += _dispatcher.sendAction
        _dispatcher.OnReceivePlayerAction += GivePlayerAction
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
        inputManager.SetOperateCharacter(ID: ID)
    }
    
    public func GivePlayerAction(action: PlayerAction){
        print("GameManager: GivePlayerAction")
        guard let character = _characterMap[action.CharacterModelID] else {
            print("Character not found")
            return
        }
        character.DoAction(action: action)
    }
}
