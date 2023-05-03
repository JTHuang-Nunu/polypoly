//
//  Wall.swift
//  polypoly
//
//  Created by mac03 on 2023/4/30.
//

import UIKit
import SpriteKit

class Wall: SKSpriteNode {
    
    init(size: CGSize) {
        super.init(texture: nil, color: .clear, size: size)
        // 設定物理屬性
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsBody?.categoryBitMask = PhysicsCategory.Boundary
        self.physicsBody?.friction = 0
        self.physicsBody?.restitution = 1
        self.physicsBody?.isDynamic = false
        
        // 建立左邊牆壁
        let leftWall = SKNode()
        leftWall.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: -self.size.width/2, y: -self.size.height/2),
                                             to: CGPoint(x: -self.size.width/2, y: self.size.height/2))
        leftWall.physicsBody?.categoryBitMask = PhysicsCategory.Wall
        self.addChild(leftWall)

        // 建立右邊牆壁
        let rightWall = SKNode()
        rightWall.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: self.size.width/2, y: -self.size.height/2),
                                              to: CGPoint(x: self.size.width/2, y: self.size.height/2))
        rightWall.physicsBody?.categoryBitMask = PhysicsCategory.Wall
        self.addChild(rightWall)

        // 建立上邊牆壁
        let topWall = SKNode()
        topWall.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: -self.size.width/2, y: self.size.height/2),
                                            to: CGPoint(x: self.size.width/2, y: self.size.height/2))
        topWall.physicsBody?.categoryBitMask = PhysicsCategory.Wall
        self.addChild(topWall)

        // 建立下邊牆壁
        let bottomWall = SKNode()
        bottomWall.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: -self.size.width/2, y: -self.size.height/2),
                                               to: CGPoint(x: self.size.width/2, y: -self.size.height/2))
        bottomWall.physicsBody?.categoryBitMask = PhysicsCategory.Wall
        self.addChild(bottomWall)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

