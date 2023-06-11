//
//  CoreProtocal.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/5/15.
//

import Foundation
import SpriteKit

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
    case Path
}

enum MessageType: String, Codable{
    case RequestRoom
    case CreateRoom
    case CancelRequest
    case PlayerAction
    case PlayerLeave
    case TestMessage
    case JoinMessage
}

struct PlayerAction: Codable & Oppositable{
    
    
    var CharacterModelID: UUID
    var ActionType: ActionType
    var Skill: Skill
    var content: [ContentType: String] = [:]
    
    var opposite: PlayerAction{
        var newAction = self
        for (key, value) in newAction.content{
            switch key{
            case .Impulse:
                newAction.content[key] = GetOppositeValue(value: value, type: CGVector.self)
                break
            default:
                break
            }
        }
        return newAction
    }
    private func GetOppositeValue<T: Oppositable & Codable>(value: String, type: T.Type)->String{
        let newValue = decodeJSON(type, jsonString: value)
        return encodeJSON(newValue?.opposite)
    }
}

struct Message: Codable{
    var DeviceID: UUID
    var MessageType: MessageType
    var Content: String = ""
}

struct RoomInfo: Codable{
    var RoomID: String
    var RoomHostInfo: HostInfo
    var PlayerInfoMap: [String: CharacterInfo] // [DeviceID: PlayerInfo]
}
struct CharacterInfo: Codable{
    var TeamID: TeamID
    var CharacterModelID: UUID
}
struct HostInfo: Codable{
    var IP: String
    var Port: Int
}
enum TeamID: String, Codable{
    case Blue
    case Red
}

struct CodablePath: Codable{
    var PointList: [CGPoint] = []
    
    public func toPath()->CGPath{
        if PointList.count == 0{
            return CGMutablePath()
        }
        let path = CGMutablePath()
        path.move(to: PointList[0])
        for point in PointList{
            path.addLine(to: point)
        }
        return path
    }
}

