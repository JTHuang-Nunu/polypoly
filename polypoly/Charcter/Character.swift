//
//  Character.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/5/24.
//

import Foundation
import SpriteKit

class Character: CharacterProtocol{
    var _healthManager = HealthManager()
    var _teamManager: TeamManager!
    var OnCreateObstacle: Event<SKNode> = Event<SKNode>()
    
    var CharacterModelID: UUID
    var ball: Ball = Ball()
    var lineList = [DrawingLine]()
    var currLine:DrawingLine!
    var currSkill: Skill = .Move
    var SKNode: SKNode{
        get{
            return ball
        }
    }
    
    var position: CGPoint {
        didSet{// initial won't trigger didSet func
            ball.position = position
            print("ballposition: ",ball.position)
        }
    }
    
    convenience init(characterModelID: UUID){
        self.init(characterModelID: characterModelID, position: CGPoint(x: 0, y: 0))
    }
    
    init(characterModelID: UUID, position: CGPoint){
        self.CharacterModelID = characterModelID
        self.position = position
        self.ball.position = self.position
        self._teamManager = TeamManager(character: self)
    }
    
    func DoAction(action: PlayerAction) {
        switch action.Skill{
        case .Move:
            characterMove(content: action.content)
        case .Obstacle:
            createObstacle(content: action.content)
            break
        case .MeteoriteFalling:
            break
        case .HpRecovery:
            break
        case .PowerRecovery:
            break
        case .TowerBuilding:
            break
        case .ObjectEnhancing:
            break
        case .GravityIncreasing:
            break
        case .ObjectRandomlyGenerated:
            break

        case .Trap:
            break
        }
    }
    
    func createObstacle(content : [ContentType: String]){
        guard let codablePath = decodeJSON(CodablePath.self, jsonString: content[.Path]!)
        else {return}
        
        let path = codablePath.toPath()

        guard let object = ObstacleObejctFactory.shared.create(type: .DrawObstacle, position: CGPoint(x: 0, y: 0), path: path)
        else {return}
        OnCreateObstacle.Invoke(object)
    }
    func characterMove(content : [ContentType: String]) {
        guard var impulse = decodeJSON(CGVector.self, jsonString: content[.Impulse]!)
        else {return}
        //- - -
        //update energy //modify impulse , when power value is insufficient
        let distance = impulse.distance
        
        var transformToPower: CGFloat{
            return distance / 5
        }
        print(distance)
        //- - -
        //push the ball by the impulse
        self.ball.physicsBody?.applyImpulse(impulse)

    }
//    func characterMove(force impulse: CGVector) {
//        //push the ball by the impulse
//        self.ball.physicsBody?.applyImpulse(impulse)
//    }
    func draw(status: TouchStatus, point: CGPoint?) {
        
        switch status {
        case .begin:
            let lineWidth: CGFloat = 10
//            let hp: CGFloat = 3
            if let point = point {
//                currLine = DrawingLine(startPoint: point, lineWidth: lineWidth, hp: CGFloat(hp))
                lineList.append(currLine)
            }
        case .move:
                if let point = point {
                    currLine.movePath(toPoint: point)
                }
            
        case .end:
            currLine.endDrawing()
        }
    }
}

