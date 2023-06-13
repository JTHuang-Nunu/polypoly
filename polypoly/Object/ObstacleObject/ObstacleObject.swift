//
//  ObstacleObject.swift
//  polypoly
//
//  Created by mac03 on 2023/6/10.
//

import Foundation
import SpriteKit

class ObstacleObejct: SKNode, ObstacleObjectProtocol {
    public let onInjured = Event<CGFloat>()
    var _healthManager = HealthManager()
    var OnObjectDied = Event<SKNode>()
    var node: SKShapeNode!
    var texture: SKSpriteNode? = nil
    
    init(node: SKShapeNode){
        self.node = node
        super.init()

        _setupBody()
    }
    init(node: SKShapeNode, texture: SKSpriteNode){
        self.node = node
        self.texture = texture
        super.init()
        _setupBody()
    }
    
    private func _setupBody(){
        self.addChild(node)
        if let texture = texture {
            self.addChild(texture)
        }
        //event
        _healthManager.OnDied += {
            self.OnObjectDied.Invoke((self))
        }
        onInjured += _healthManager.InjureHP
        //physical setting
        self.physicsBody?.categoryBitMask = PhysicsCategory.Obstacle
        self.physicsBody?.collisionBitMask = PhysicsCategory.Ball | PhysicsCategory.Obstacle
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Ball | PhysicsCategory.Obstacle
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
