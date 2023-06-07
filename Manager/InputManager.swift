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
    var currentSkill: Skill? = nil
    var OperateCharacterID: UUID? = nil
    var canvas: Canvas? = nil
    let logger = Logger(subsystem: "InputManager", category: "InputManager")

    public func SetCanvas(canvas: Canvas){
        self.canvas = canvas
        self.canvas!.OnDrawPointer += InputPointer
        self.canvas!.OnDrawLine += InputLine
    }
    
    public func SetSelectedSkill(skill: Skill){
        currentSkill = skill
    }
    
    public func SetOperateCharacter(ID: UUID){
        OperateCharacterID = ID
    }
    public func InputLine(line: CGPath){
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
        action.content[.Path] = encodeJSON(5)
        OnDoPlayerAction.Invoke(action)
    }
    
    public func InputPointer(vector: CGVector){
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
        OnDoPlayerAction.Invoke(action)
    }
}
