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
}

enum ContentType: Codable{
    case Impulse
    case Position
}

enum RequestType: String, Codable{
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
    var content: [ContentType: String]
}

struct Message: Codable{
    var PlayerID: UUID
    var MessageType: RequestType
    var Content: String = ""
}
