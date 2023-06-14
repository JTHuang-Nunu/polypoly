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
    var len: CGFloat!
    init() {
//        let ballTexture = SKTexture(imageNamed: "ball51.png")
        let atlas = SKTextureAtlas(named: BallSkinFolder)
        // 取得 Atlas 中所有的圖片名稱
        let textureNames = atlas.textureNames
        // 隨機選擇一張圖片名稱
        let randomTextureName = textureNames.randomElement()
        // 從 Atlas 中取得隨機選擇的圖片
        let randomTexture = atlas.textureNamed(randomTextureName!)
        var ballTexture = randomTexture
        
        self.len = 50
        let ballSize = CGSize(width: len, height: len)
        
        super.init(texture: ballTexture, color: .clear, size: ballSize)
        self._setupoBody(ballSize: ballSize)
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.name = SoccerName
    }
    
    init(len: CGFloat) {
//        let ballTexture = SKTexture(imageNamed: "ball51.png")
        let atlas = SKTextureAtlas(named: BallSkinFolder)
        // 取得 Atlas 中所有的圖片名稱
        let textureNames = atlas.textureNames
        // 隨機選擇一張圖片名稱
        let randomTextureName = textureNames.randomElement()
        // 從 Atlas 中取得隨機選擇的圖片
        let randomTexture = atlas.textureNamed(randomTextureName!)
        var ballTexture = randomTexture
        
        self.len = len
        let ballSize = CGSize(width: len, height: len)
        
        super.init(texture: ballTexture, color: .clear, size: ballSize)
        self._setupoBody(ballSize: ballSize)
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.name = SoccerName
    }
    
    private func _setupoBody(ballSize: CGSize){
        let ballRadius = len!/2.5
        let ballRestitution: CGFloat = 0
        let ballFriction: CGFloat = 0
        let ballLinearDamping: CGFloat = 0.1
        let ballAngularDamping: CGFloat = 0.5
        
        self.name = BallName
        self.physicsBody = SKPhysicsBody(circleOfRadius: ballRadius)
        let tmp = SKShapeNode(circleOfRadius: ballRadius)
               tmp.fillColor = .red
               addChild(tmp)
//        self.physicsBody?.usesPreciseCollisionDetection = true
//        self.physicsBody?.isDynamic = true
        self.physicsBody?.categoryBitMask = PhysicsCategory.Ball
        self.physicsBody?.collisionBitMask = PhysicsCategory.Boundary | PhysicsCategory.Ball | PhysicsCategory.Obstacle | PhysicsCategory.Explosion
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Boundary | PhysicsCategory.Ball | PhysicsCategory.Obstacle | PhysicsCategory.Explosion | PhysicsCategory.BlackHole | PhysicsCategory.GoalLine
        
        self.physicsBody?.mass = PhysicsMass.Ball
        self.physicsBody?.restitution = ballRestitution
        self.physicsBody?.friction = ballFriction
        self.physicsBody?.linearDamping = ballLinearDamping
        self.physicsBody?.angularDamping = ballAngularDamping
//        self.physicsBody?.affectedByGravity = false
    }
    private func _randomSkin() -> SKTexture {
        // 建立一個 SKTextureAtlas 物件
        let atlas = SKTextureAtlas(named: BallSkinFolder)

        // 取得 Atlas 中所有的圖片名稱
        let textureNames = atlas.textureNames

        // 隨機選擇一張圖片名稱
        let randomTextureName = textureNames.randomElement()

        // 從 Atlas 中取得隨機選擇的圖片
        let randomTexture = atlas.textureNamed(randomTextureName!)

        // 使用隨機選擇的圖片來建立 SKSpriteNode
//        let spriteNode = SKSpriteNode(texture: randomTexture)
        return randomTexture
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
