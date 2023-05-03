//
//  Ball.swift
//  polypoly
//
//  Created by mac03 on 2023/4/30.
//

import UIKit
import SpriteKit

class Ball: SKSpriteNode {
    init() {
        let ballTexture = SKTexture(imageNamed: "ball")
        let ballSize = CGSize(width: 32, height: 32)
        
        super.init(texture: ballTexture, color: .clear, size: ballSize)
        self._setupoBody(ballSize: ballSize)
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    }
    
    private func _setupoBody(ballSize: CGSize){
        let ballRadius = ballSize.width / 2.0
        let ballMass: CGFloat = 2
        let ballRestitution: CGFloat = 0.9
        let ballFriction: CGFloat = 0.2
        let ballLinearDamping: CGFloat = 0.1
        let ballAngularDamping: CGFloat = 0.5
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: ballRadius)
        self.physicsBody?.mass = ballMass
        self.physicsBody?.restitution = ballRestitution
        self.physicsBody?.friction = ballFriction
        self.physicsBody?.linearDamping = ballLinearDamping
        self.physicsBody?.angularDamping = ballAngularDamping
        self.physicsBody?.affectedByGravity = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
