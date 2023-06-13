//
//  ExplosionAnimation.swift
//  polypoly
//
//  Created by mac03 on 2023/6/8.
//

import Foundation
import UIKit
import SpriteKit

class ExplosionByTrap: SKNode, AnimationProtocol {
    
    let folderName = Explosion1Folder
    var node = SKSpriteNode()
    let len =  250
    var textures: [SKTexture]?
    
    override init() {
        let atlas = SKTextureAtlas(named: folderName)
        textures = (0...atlas.textureNames.count-1).map { atlas.textureNamed(String(format: "%d", $0))}
        node.size = CGSize(width: len, height: len)
        super.init()
        
        let circle = SKShapeNode(circleOfRadius: 50)
        circle.fillColor = .red
        addChild(circle)
    }
    
    public func play() -> SKNode? {
        guard let textures = textures else { return nil }
        
        let animation = SKAction.animate(with: textures, timePerFrame: 0.05)
        node.run(SKAction.sequence([animation, SKAction.removeFromParent()]))
        node.zPosition = zAxis.skillAnimation
        self.addChild(node)
        
        // 增加爆炸力量
        self.physicsBody = SKPhysicsBody(circleOfRadius: 1)
        let explosionForce = SKFieldNode.radialGravityField()
        explosionForce.name = "explosionForce"
        explosionForce.region = SKRegion(radius: 50)
        explosionForce.strength = -3.0 // 設定爆炸力量大小
        explosionForce.falloff = 1 // 設定力量衰減值
        //
        
        node.physicsBody = SKPhysicsBody(circleOfRadius: 50)
        node.physicsBody?.categoryBitMask = PhysicsCategory.Explosion
        node.physicsBody?.contactTestBitMask = PhysicsCategory.Ball
        explosionForce.position = node.position
        node.addChild(explosionForce)
        
        return self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ExplosionAnimation: SKNode, AnimationProtocol {

    let folderName = Explosion1Folder
    var node = SKSpriteNode()
    let len = 200
    var textures: [SKTexture]?
    override init(){
        let atlas = SKTextureAtlas(named: folderName)
        textures = (0...atlas.textureNames.count-1).map { atlas.textureNamed(String(format: "%d", $0))}
        node.size = CGSize(width: len, height: len)

        super.init()
    }
    public func play() -> SKNode?{
        guard let textures = textures else {return nil}

        let animation = SKAction.animate(with: textures, timePerFrame: 0.03)
        node.run(SKAction.sequence([animation, SKAction.removeFromParent()]))
        node.zPosition = zAxis.skillAnimation
        self.addChild(node)
        return self
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ExplosionAnimation2: SKNode, AnimationProtocol {
    
    let folderName = Explosion2Folder
    var node = SKSpriteNode()
    let len = 200
    var textures: [SKTexture]?
    override init(){
        let atlas = SKTextureAtlas(named: folderName)
        textures = (0...atlas.textureNames.count-1).map { atlas.textureNamed(String(format: "%d", $0))}
        node.size = CGSize(width: len, height: len)
        
        super.init()
    }
    public func play() -> SKNode?{
        guard let textures = textures else {return nil}
        
        let animation = SKAction.animate(with: textures, timePerFrame: 0.04)
        node.run(SKAction.sequence([animation, SKAction.removeFromParent()]))
        node.zPosition = zAxis.skillAnimation
        node.position  = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
        self.addChild(node)
        return self
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



