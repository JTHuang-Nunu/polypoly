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
        super.init(node: SKShapeNode(circleOfRadius: 30), texture: SKSpriteNode(imageNamed: BuildingName))
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
