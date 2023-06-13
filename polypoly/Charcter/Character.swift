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
    
    public let OnCreateObstacle = Event<SKNode>()
    
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
        self.ball.onInjured += _healthManager.InjureHP
//        self.ball.onBomb +=
        self._teamManager = TeamManager(character: self)
        _healthManager.OnDied += gameOver
    }
    
    func DoAction(action: PlayerAction) {
        switch action.Skill{
        case .Move:
            characterMove(content: action.content)
        case .Obstacle:
            createObstacle(content: action.content)
        case .Trap:
            createTrap(content: action.content)
            
        case .MeteoriteFalling:
            break
        case .HpRecovery:
            break
        case .EnerergyRecovery:
            break
        case .TowerBuilding:
            createBuilding(content: action.content)
            break
        case .ObjectEnhancing:
            break
        case .GravityIncreasing:
            break
        case .ObjectRandomlyGenerated:
            break
        }
    }
    //=======================================================
    // Create Obstacle
    func createObstacle(content : [ContentType: String]){
        guard let codablePath = decodeJSON(CodablePath.self, jsonString: content[.Path]!) else {return}
        let path = codablePath.toPath()

        guard let object = ObstacleObejctFactory.shared.create(type: .DrawObstacle, position: CGPoint(x: 0, y: 0), path: path)
        else {return}
        object.OnObjectDied += _teamManager.removeObject //Add event: when object health == 0, remove from team container
//        object.OnObjectDied += removeChild               //Add event: when object health == 0, remove from character
        OnCreateObstacle.Invoke(object)
    }
    //=======================================================
    // Create Trap
    func createTrap(content : [ContentType: String]){
        //only need last position
        guard let locate = decodeJSON(CGPoint.self, jsonString: content[.Position]!) else {return}
        
        //call object factory to create
        guard let object = ObstacleObejctFactory.shared.create(type: .Trap, position: locate, path: nil) else {return}

        object.OnObjectDied += _teamManager.removeObject //Add event: when object health == 0, remove from team container
        let trap = object as! Trap //needed
//        trap.OnTrigger += removeChild
        OnCreateObstacle.Invoke(trap)
    }
    //=======================================================
    // Create Building
    func createBuilding(content : [ContentType: String]){
        //only need last position
        guard let locate = decodeJSON(CGPoint.self, jsonString: content[.Position]!) else {return}
        
        //call object factory to create
        guard let object = ObstacleObejctFactory.shared.create(type: .Building, position: locate, path: nil) else {return}

        object.OnObjectDied += _teamManager.removeObject //Add event: when object health == 0, remove from team container
        object.OnObjectDied += removeChild

        OnCreateObstacle.Invoke(object)
    }
    //=======================================================
    // Character Move
    func characterMove(content : [ContentType: String]) {
        guard let contentImpulse = content[.Impulse] else {
            print("[Move] impulse is nil")
            return
        }
        guard var impulse = decodeJSON(CGVector.self, jsonString: contentImpulse)
        else {return}
//        //- - -
//        //update energy //modify impulse , when power value is insufficient
//        let distance = impulse.distance
//
//        var transformToPower: CGFloat{
//            return distance / 5
//        }
//        print(distance)
//        //- - -
        //push the ball by the impulse
        self.ball.physicsBody?.applyImpulse(impulse)

    }
    //=======================================================
    func removeChild(node: SKNode){
        node.removeFromParent()
    }
    
    func gameOver(){
        print("=112312323123==\(self.CharacterModelID.uuidString.prefix(5)) lose the game==12312311231=")
    }
}

