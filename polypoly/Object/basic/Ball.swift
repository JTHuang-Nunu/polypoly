//
//  Ball.swift
//  polypoly
//
//  Created by mac03 on 2023/4/30.
//

import UIKit
import SpriteKit

class Ball: SKSpriteNode {
    public let onInjured = Event<CGFloat>()
    public let onBomb = Event<(CGVector, CGFloat)>()
    init() {
        let ballTexture = SKTexture(imageNamed: BallName)
        let ballSize = CGSize(width: 32, height: 32)
        
        super.init(texture: ballTexture, color: .clear, size: ballSize)
        self._setupoBody(ballSize: ballSize)
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    }
    
    private func _setupoBody(ballSize: CGSize){
        let ballRadius = ballSize.width / 2.0
        let ballRestitution: CGFloat = 0
        let ballFriction: CGFloat = 0
        let ballLinearDamping: CGFloat = 0.1
        let ballAngularDamping: CGFloat = 0.5
        
        self.name = BallName
        self.physicsBody = SKPhysicsBody(circleOfRadius: ballRadius)
//        self.physicsBody?.usesPreciseCollisionDetection = true
//        self.physicsBody?.isDynamic = true
        self.physicsBody?.categoryBitMask = PhysicsCategory.Ball
        self.physicsBody?.collisionBitMask = PhysicsCategory.Boundary | PhysicsCategory.Ball | PhysicsCategory.Obstacle | PhysicsCategory.Explosion
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Boundary | PhysicsCategory.Ball | PhysicsCategory.Obstacle | PhysicsCategory.Explosion
        
        self.physicsBody?.mass = PhysicsMass.Ball
        self.physicsBody?.restitution = ballRestitution
        self.physicsBody?.friction = ballFriction
        self.physicsBody?.linearDamping = ballLinearDamping
        self.physicsBody?.angularDamping = ballAngularDamping
//        self.physicsBody?.affectedByGravity = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
