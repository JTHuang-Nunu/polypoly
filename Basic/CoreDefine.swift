//
//  CoreProtocal.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/5/15.
//

import Foundation

enum TouchStatus: Codable{
    case begin
    case move
    case end
}

enum ActionType: Codable {
    case UseSkill
    case ChooseSkill
}

enum ContentType: Codable{
    case Impulse
    case Position
    case HealthPoint
    case Energy
}

enum MessageType: String, Codable{
    case RequestRoom
    case CreateRoom
    case CancelRequest
    case PlayerAction
    case PlayerLeave
    case TestMessage
}

struct PlayerAction: Codable{
    var CharacterModelID: UUID
    var ActionType: ActionType
    var Skill: Skill
    var content: [ContentType: String] = [:]
}

struct PlayerStats: Codable{
    var CharacterModelID: UUID
    var content: [ContentType: String] = [:]
}

struct Message: Codable{
    var DeviceID: UUID
    var MessageType: MessageType
    var Content: String = ""
}
