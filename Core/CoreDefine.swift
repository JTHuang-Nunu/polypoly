//
//  CoreProtocal.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/5/15.
//

import Foundation

enum ActionType{
    case ChooseAbility
    case UseAbility
}


protocol PlayerAction: Codable{
    var CharacterModelID: UUID {get set}
    var ActionType: ActionType {get set}
    var AbilityID: Int {get set}
    var ActionTime: Date {get set}
}

protocol CharacterAction {
    var CharacterModelID: UUID {get set}
    func DoAction(action: PlayerAction)
}

protocol PlayerController {
    func OnDoAction(action: (PlayerAction)->Void)
}
