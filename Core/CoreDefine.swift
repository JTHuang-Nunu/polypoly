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


struct PlayerAction: Codable{
    var CharacterModelID: UUID
    var ActionType: ActionType
    var AbilityID: Int
    var ActionTime: Date
}

protocol CharacterModel {
    var CharacterModelID: UUID {get set}
    func DoAction(action: PlayerAction)
}

protocol PlayerInputController {
    func OnDoAction(action: (PlayerAction)->Void)
}


enum RequestType: String, Codable{
    case RequestRoom
    case CreateRoom
    case CancelRequest
    case PlayerAction
    case PlayerLeave
    case TestMessage
}

struct Message: Codable{
    var PlayerID: UUID
    var MessageType: RequestType
    var Content: String = ""
}
