//
//  Wall.swift
//  polypoly
//
//  Created by mac03 on 2023/4/30.
//

import UIKit
import SpriteKit

class Wall: SKSpriteNode {
    public let onTouched = Event<Void>()
    var node: SKShapeNode?
    init(size: CGSize, color: UIColor) {
//        let size = CGSize(width: 500, height: 500)
        super.init(texture: nil, color: color, size: size)
        
        self._setupBody(size: size)
//        let shapeNode = SKShapeNode(rectOf: size)
//        shapeNode.fillColor = .red
//        addChild(shapeNode)
        
        onTouched += addFadeAnimation
        
        let width = size.width
        let height = size.height
        
        //draw color
        node = SKShapeNode(rect: CGRect(origin: CGPoint(x: -width/2, y: -height/2), size:  CGSize(width: width, height: height)))

        node!.strokeColor = UIColor(cgColor: CGColor(gray: 1, alpha: 0.2))
        node!.lineWidth = 5
        node!.zPosition = zAxis.Base
        addChild(node!)
        
    }
    func addFadeAnimation(){
        let fadeIn = SKAction.fadeAlpha(to: 3.0, duration: 0.6)
        let fadeOut = SKAction.fadeAlpha(to: 0.7, duration: 0.6)
        let fade = SKAction.sequence([fadeOut, fadeIn])
        let reset = SKAction.run {
            self.node!.strokeColor = UIColor(cgColor: CGColor(gray: 1, alpha: 0.2))
        }
        let repeatPulse = SKAction.repeat(fade, count: 3)
        node!.run(SKAction.sequence([repeatPulse ,reset]))
        
    }
    private func _setupBody(size: CGSize){
        // 設定物理屬性
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsBody?.categoryBitMask = PhysicsCategory.Boundary
        self.physicsBody?.collisionBitMask = PhysicsCategory.Ball
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Ball
        self.physicsBody?.friction = 0
        self.physicsBody?.restitution = 1
        self.physicsBody?.isDynamic = false
        self.name = WallName
        
        self._setSidesOfWall(size: size)
//        self.position = position    //Position is set behind the wall group
    }
    
    //Create Sides of Wall
    private func _setSidesOfWall(size: CGSize){
        // 建立左邊牆壁
        let leftWall = SKNode()
        leftWall.name = "leftWall"
        leftWall.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: -self.size.width/2, y: -self.size.height/2),
                                             to: CGPoint(x: -self.size.width/2, y: self.size.height/2))
        leftWall.physicsBody?.categoryBitMask = PhysicsCategory.Wall
        self.addChild(leftWall)

        // 建立右邊牆壁
        let rightWall = SKNode()
        rightWall.name = "rightWall"
        rightWall.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: self.size.width/2, y: -self.size.height/2),
                                              to: CGPoint(x: self.size.width/2, y: self.size.height/2))
        rightWall.physicsBody?.categoryBitMask = PhysicsCategory.Wall
        self.addChild(rightWall)

        // 建立上邊牆壁
        let topWall = SKNode()
        topWall.name = "topWall"
        topWall.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: -self.size.width/2, y: self.size.height/2),
                                            to: CGPoint(x: self.size.width/2, y: self.size.height/2))
        topWall.physicsBody?.categoryBitMask = PhysicsCategory.Wall
        self.addChild(topWall)

        // 建立下邊牆壁
        let bottomWall = SKNode()
        bottomWall.name = "bottomWall"
        bottomWall.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: -self.size.width/2, y: -self.size.height/2),
                                               to: CGPoint(x: self.size.width/2, y: -self.size.height/2))
        bottomWall.physicsBody?.categoryBitMask = PhysicsCategory.Wall
        self.addChild(bottomWall)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

