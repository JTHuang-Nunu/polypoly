//
//  LoseAnimation.swift
//  polypoly
//
//  Created by mac03 on 2023/6/14.
//

import Foundation
import SpriteKit
class LoseAnimation: SKNode, AnimationProtocol {
    
    let folderName = LoseFolder
    var node = SKSpriteNode()
    let len = 300
    var textures: [SKTexture]?
    override init(){
        let atlas = SKTextureAtlas(named: folderName)
        textures = (0...atlas.textureNames.count-2).map { atlas.textureNamed(String(format: "%d", $0))}
        node.size = textures![0].size() * 5.5
        node.zPosition = zAxis.skillAnimation
//        node.position  = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
        super.init()
    }
    public func play() -> SKNode?{
        guard let textures = textures else {return nil}
        let frameOfTime = 0.3
        let duration = frameOfTime * Double(textures.count)
        let animation = SKAction.animate(with: textures, timePerFrame: frameOfTime)
        let repeatAction = SKAction.repeatForever(animation)
        
//        let fadeout = SKAction.fadeOut(withDuration: duration)
//        let scale = SKAction.scale(to: 0.2, duration: duration)
//        let group = SKAction.group([animation, fadeout, scale])
//        let wait = SKAction.wait(forDuration: 0.2)
        
        node.run(SKAction.sequence([repeatAction]))
        
        self.addChild(node)
        
        
        let screenSize = UIScreen.main.bounds.size
        let skNode = SKShapeNode(rectOf: screenSize)
        skNode.fillColor = UIColor(cgColor:  CGColor(gray: 0.9, alpha: 1.0))
        addChild(skNode)
        
        let backgroundImage = SKTexture(imageNamed: "lose")
        let backgroundNode = SKSpriteNode(texture: backgroundImage, size: backgroundImage.size() * 5)
//        backgroundNode.zPosition = zAxis.skillAnimation // 設定在場景最下層
        self.zPosition = zAxis.OverlapAll
        addChild(backgroundNode)
        
        return self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
