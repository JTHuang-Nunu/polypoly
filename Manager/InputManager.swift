//
//  PlayerController.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/5/24.
//

import Foundation
import UIKit
import os

class InputManager: InputManagerProtocol{
    let OnDoPlayerAction: Event<PlayerAction> = Event<PlayerAction>()
    private var currentSkill: Skill? = nil
    var OperateCharacterID: UUID? = nil
    var canvas: Canvas? = nil
    var energyManager: EnergyManager? = nil
    let logger = Logger(subsystem: "InputManager", category: "InputManager")
    let SkillCanvasModeMap: [Skill: CanvasMode] = [
        .Move: .Pointer,
        .Obstacle: .Draw,
        .Trap: .Locate,
        .TowerBuilding: .Locate,
        .MeteoriteFalling: .Locate
    ]
    let SkillCost: [Skill: Int] = [
        .Move: 1,
        .Obstacle: 3,
        .Trap: 0,
        .TowerBuilding: 0
    ]
    
    public func SetCanvas(canvas: Canvas){
        self.canvas = canvas
        self.canvas!.OnDrawPointer += InputPointer
        self.canvas!.OnDrawLine += InputLine
        self.canvas!.OnDrawLocate += InputLocate
    }
    
    public func SetEnergyManager(energyManager: EnergyManager){
        self.energyManager = energyManager
    }
    
    private func GeneratePlayerAction(action: PlayerAction){
        let cost = self.GetPlayerActionCost(action: action)
        if self.energyManager!.Value < cost{
            return
        }
        
        self.energyManager!.Cost(costValue: cost)
        var newAction = action
        newAction.GenerateTime = Date()
        OnDoPlayerAction.Invoke(newAction)
    }
    
    
    public func SetSelectedSkill(skill: Skill){
        currentSkill = skill
        print("now select [\(skill)] skill")
        canvas?.SetMode(mode: SkillCanvasModeMap[currentSkill!]!)
    }
    
    public func SetOperateCharacter(ID: UUID){
        OperateCharacterID = ID
    }
    private func InputLine(line: CodablePath){
        if currentSkill == nil{
            logger.error("Skill not set")
            return
        }
        guard let OperateCharacterID = OperateCharacterID else {
            logger.error("OperateCharacterID not set")
            return
        }
        var action = PlayerAction(
            CharacterModelID: OperateCharacterID,
            ActionType: .UseSkill,
            Skill: currentSkill!)
        action.content[.Path] = encodeJSON(line)
        GeneratePlayerAction(action: action)
    }
    
    private func GetPlayerActionCost(action: PlayerAction) -> Float{
        let cost = SkillCost[action.Skill]!
        return Float(cost)
    }
    
    
    
    private func InputPointer(vector: CGVector){
        if currentSkill == nil{
            logger.error("Skill not set")
            return
        }
        guard let OperateCharacterID = OperateCharacterID else {
            logger.error("OperateCharacterID not set")
            return
        }
        var action = PlayerAction(
            CharacterModelID: OperateCharacterID,
            ActionType: .UseSkill,
            Skill: currentSkill!)
        
        action.content[.Impulse] = encodeJSON(vector)
        GeneratePlayerAction(action: action)
    }
    private func InputLocate(locate: CGPoint){
        if currentSkill == nil{
            logger.error("Skill not set")
            return
        }
        guard let OperateCharacterID = OperateCharacterID else {
            logger.error("OperateCharacterID not set")
            return
        }
        var action = PlayerAction(
            CharacterModelID: OperateCharacterID,
            ActionType: .UseSkill,
            Skill: currentSkill!)
        
        // send Locate data
        print(locate)
        action.content[.Position] = encodeJSON(locate)
        GeneratePlayerAction(action: action)
    }
}
