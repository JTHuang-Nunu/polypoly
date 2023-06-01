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

enum ContentType:Codable{
    case Impulse
    case Str
}
struct PlayerAction: Codable{
    var CharacterModelID: UUID
    var ActionType: ActionType
    var Skill: Skill
    var content: [ContentType: String]
}

protocol CharacterModel {
    var CharacterModelID: UUID { get set }
    var lineList: [DrawingLine] { get set }

    func DoAction(action: PlayerAction)
}

protocol PlayerInputControllerProtocol {
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
