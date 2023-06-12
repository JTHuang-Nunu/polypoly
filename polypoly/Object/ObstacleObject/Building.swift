//
//  Building.swift
//  polypoly
//
//  Created by mac03 on 2023/6/10.
//

import Foundation
import SpriteKit


class BuildingObstacle: ObstacleObejct {
    
    init(position: CGPoint){
        super.init(node: SKShapeNode(circleOfRadius: 30), texture: SKSpriteNode(imageNamed: "building"))
        self.position = position

        
        self._setupBody()
    }

    private func _setupBody(){
        self.name = "building"
        //node setting
        node.strokeColor = .orange
        node.fillColor = .yellow
        
        //physics setting
        self.physicsBody = SKPhysicsBody(circleOfRadius: 30)
        self.physicsBody?.mass = PhysicsMass.Building
        self.physicsBody?.restitution = 0.2
        self.physicsBody?.friction = 0.2
        
        //health point setting
        _healthManager.initHP(maxHP: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//class BuildingObstacle: SKNode, ObstacleObjectProtocol {
//    var healthManager = HealthManager()
//
//    var node: SKShapeNode!
//    var texture: SKSpriteNode? = nil
////    var path: CGPath? = nil
//
//    public func updateHP(val: CGFloat, type: HealthType){
////        print("\(type): \(val)")
//        healthManager.update(val: val, type: .Injure)
//    }
//
//    init(position: CGPoint){
//        self.node = SKShapeNode(circleOfRadius: 30)
//        self.texture = SKSpriteNode(imageNamed: "building")
//
//        super.init()
//        self.position = position
//
//        self._setupBody()
//    }
//
//    private func _setupBody(){
//        self.name = "building"
//        //add child
//        self.addChild(node)
//
//        if let texture = texture{
//            self.addChild(texture)
//        }
//        //node setting
//        node.strokeColor = .orange
//        node.fillColor = .yellow
//
//        //physics setting
//        self.physicsBody = SKPhysicsBody(circleOfRadius: 30)
//        self.physicsBody?.categoryBitMask = PhysicsCategory.Obstacle
//        self.physicsBody?.collisionBitMask = PhysicsCategory.Ball
//        self.physicsBody?.contactTestBitMask = PhysicsCategory.Ball
//        self.physicsBody?.mass = PhysicsMass.Building
//        self.physicsBody?.restitution = 0
//        self.physicsBody?.friction = 0.2
//
//        //health point setting
//        healthManager.initHP(maxHP: 1)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
////
