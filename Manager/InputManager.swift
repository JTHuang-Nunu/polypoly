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
    var OperateCharacterID: UUID? = nil
    public func SetOperateCharacter(ID: UUID){
        OperateCharacterID = ID
    }
    
    public func InputPointer(vector: CGVector){
        guard let OperateCharacterID = OperateCharacterID else {
            print("OperateCharacterID not set")
            return
        }
        print("Input pointer")
        var action = PlayerAction(
            CharacterModelID: OperateCharacterID,
            ActionType: .UseSkill,
            Skill: .Move)
        action.content[.Impulse] = encodeJSON(vector)
        OnDoPlayerAction.Invoke(action)
    }
}
