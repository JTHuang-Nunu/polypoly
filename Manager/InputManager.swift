//
//  PlayerController.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/5/24.
//

import Foundation
import UIKit

class InputManager: InputManagerProtocol{
    let OnDoPlayerAction: Event<PlayerAction> = Event<PlayerAction>()
    let OnUpdatePlayerStats: Event<PlayerStats> = Event<PlayerStats>()
    let encoder = JSONEncoder()
    var OperateCharacterID: UUID? = nil
    public static let shared = InputManager()
    public func SetOperateCharacter(ID: UUID){
        OperateCharacterID = ID
    }
    
    public func InputPointer(vector: CGVector){
        guard let operateCharacterID = OperateCharacterID else {
            print("OperateCharacterID not set")
            return
        }
        print("Input pointer")
        var action = PlayerAction(
            CharacterModelID: operateCharacterID,
            ActionType: .UseSkill,
            Skill: .Move)
        action.content[.Impulse] = encodeJSON(vector)
        OnDoPlayerAction.Invoke(action)
    }
    
    public func updatePlayerStats(health: CGFloat?, energy: CGFloat?, statsType: StatsType) {
        guard let operateCharacterID = OperateCharacterID else {
            print("OperateCharacterID not set")
            return
        }
        
        print("Updating player stats")
        
        var stats = PlayerStats(
            CharacterModelID: operateCharacterID,
            statsType: statsType
        )
        stats.content[.HealthPoint] = encodeJSON(health)
        stats.content[.Energy] = encodeJSON(energy)
    
        OnUpdatePlayerStats.Invoke(stats)
    }
    
    public func selectSkill(skill: Skill) {
        guard let operateCharacterID = OperateCharacterID else {
            print("OperateCharacterID not set")
            return
        }
        
        print("Selecting Skill")
        
        let action = PlayerAction(
            CharacterModelID: operateCharacterID,
            ActionType: .ChooseSkill,
            Skill: skill)
        
        OnDoPlayerAction.Invoke(action)
    }
    private func encodeJSON(_ message: Codable)-> String{
        do{
            let jsonData = try encoder.encode(message)
            return String(data: jsonData, encoding: .utf8)!
        }catch{
            print(error)
        }
        return ""
    }
    
    
}
