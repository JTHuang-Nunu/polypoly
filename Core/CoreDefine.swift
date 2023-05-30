//
//  CoreProtocal.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/5/15.
//

import Foundation



enum ActionType: Codable {
    //選擇能力
    case ChooseAbility
    //使用能力
    case UseAbility
    
    case Move
    
    case Draw(drawStatus)
    enum drawStatus: Codable{
        case begin
        case move
        case end
    }
}


struct PlayerAction: Codable{
    var CharacterModelID: UUID
    var ActionType: ActionType
    var AbilityID: Int
    var ActionTime: Date
}

protocol CharacterModel {
    var CharacterModelID: UUID {get set}
    func DoAction(action: PlayerAction, point: CGPoint?, impulse: CGVector?)
}

protocol PlayerInputController {
    
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
