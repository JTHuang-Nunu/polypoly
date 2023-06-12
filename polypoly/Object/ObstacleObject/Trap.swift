//
//  Trap.swift
//  polypoly
//
//  Created by mac03 on 2023/6/13.
//

import Foundation
import SpriteKit

class Trap: ObstacleObejct {
    
    init(position: CGPoint){
        super.init(node: SKShapeNode(circleOfRadius: 30), texture: SKSpriteNode(imageNamed: TrapName))
        self.position = position

        self._setupBody()
    }

    private func _setupBody(){
        self.name = BuildingName
        //node setting
        node.strokeColor = .orange
        node.fillColor = .yellow
        
        //physics setting
        self.physicsBody = SKPhysicsBody(circleOfRadius: 30)
        self.physicsBody?.mass = PhysicsMass.trap
        self.physicsBody?.restitution = 0.2
        self.physicsBody?.friction = 0.2
        
        //override super's physicsbody
        super.physicsBody?.collisionBitMask = PhysicsCategory.Obstacle //trap 會被obstacle撞飛 但他不會被玩家撞飛 因為玩家踩到的時候會爆炸
        
        //health point setting
        _healthManager.initHP(maxHP: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
