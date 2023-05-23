//
//  CoreProtocal.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/5/15.
//

import Foundation

enum ActionType: Codable {
    case ChooseAbility
    case UseAbility
}


protocol PlayerAction: Codable{
    var CharacterModelID: UUID {get set}
    var ActionType: ActionType {get set}
    var AbilityID: Int {get set}
    var ActionTime: Date {get set}
}

protocol CharacterModel {
    var CharacterModelID: UUID {get set}
    func DoAction(action: PlayerAction)
}

protocol PlayerController {
    func OnDoAction(action: (PlayerAction)->Void)
}


enum RequestType: String, Codable{
    case RequestRoom
    case CancelRequest
    case PlayerAction
    case PlayerLeave
}

struct Message: Codable{
    var PlayerID: UUID
    var MessageType: RequestType
    var Content: String = ""
}
