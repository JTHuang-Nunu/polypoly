//
//  ObstacleObject.swift
//  polypoly
//
//  Created by mac03 on 2023/6/10.
//

import Foundation
import SpriteKit

class ObstacleObejct: SKNode, ObstacleObjectProtocol {
    var healthManager = HealthManager()
    
    var node: SKShapeNode!
    var texture: SKSpriteNode? = nil
    
//    var path: CGPath? = nil
    
    public func updateHP(type: HealthType, val: CGFloat){
//        print("\(type): \(val)")
        healthManager.update(val: val, type: .Injure)
    }
    
    init(node: SKShapeNode, texture: SKSpriteNode){
        self.node = node
        self.texture = texture
        super.init()
        _setupBody()
    }
    init(node: SKShapeNode){
        self.node = node
        super.init()
        _setupBody()
    }

    private func _setupBody(){
        self.addChild(node)
        if let texture = texture {
            self.addChild(texture)
        }
        //physical setting
        self.physicsBody?.categoryBitMask = PhysicsCategory.Obstacle
        self.physicsBody?.collisionBitMask = PhysicsCategory.Ball | PhysicsCategory.Obstacle
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Ball | PhysicsCategory.Obstacle
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
