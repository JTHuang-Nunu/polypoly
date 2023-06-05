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

struct Message: Codable{
    var DeviceID: UUID
    var MessageType: MessageType
    var Content: String = ""
}

struct RoomInfo: Codable{
    var RoomID: String
    var PlayerIDList: [String]
    var RoomHostInfo: HostInfo
}
struct HostInfo: Codable{
    var IP: String
    var Port: Int
}
