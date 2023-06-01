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
enum PlayerSkill: Codable{
    case Move
    case Summon
}
enum ActionType: Codable {
    //選擇能力
    case ChooseSkill
    //使用能力
    case UseSkill
    
    case Move
    
    case Draw(TouchStatus)
}


struct PlayerAction: Codable{
    var CharacterModelID: UUID
    var ActionType: ActionType
    var SkillID: Int
    var ActionTime: Date
    
    //for drawing
    var point: CGPoint
    //for ball moving
    var impulse: CGVector
}

protocol CharacterModel {
    var CharacterModelID: UUID { get set }
    var lineList: [DrawingLine] { get set }

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
