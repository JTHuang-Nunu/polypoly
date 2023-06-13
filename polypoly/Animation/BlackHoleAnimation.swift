//
//  BlackHoleAnimation.swift
//  polypoly
//
//  Created by mac03 on 2023/6/10.
//

import Foundation
import SpriteKit
class BlackHoleAnimation: SKNode, AnimationProtocol {
    
    let folderName = BlackHoleFolder
    var node = SKSpriteNode()
    let len = 100
    var textures: [SKTexture]?
    override init(){
        let atlas = SKTextureAtlas(named: folderName)
        textures = (0...atlas.textureNames.count-1).map { atlas.textureNamed(String(format: "%d", $0))}
        node.size = CGSize(width: len, height: len)
        node.zPosition = zAxis.skillAnimation
        node.position  = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
        super.init()
    }
    public func play() -> SKNode?{
        guard let textures = textures else {return nil}
        let frameOfTime = 0.05
        let duration = frameOfTime * Double(textures.count)
        let animation = SKAction.animate(with: textures, timePerFrame: frameOfTime)
        let fadeout = SKAction.fadeOut(withDuration: duration)
        let scale = SKAction.scale(to: 0.2, duration: duration)
        let group = SKAction.group([animation, fadeout, scale])
        
        let blackCurtainAction = SKAction.run(self.blackCurtainAction)
        
        node.run(SKAction.sequence([group, blackCurtainAction, SKAction.removeFromParent()]))
        
        self.addChild(node)
        return self
    }
    func blackHoleAction() {

    }
    func blackCurtainAction(){
        let size = UIScreen.main.bounds.size
//        let blackCircle1 = SKSpriteNode(color: .black,  size: size)
        let blackCircle = SKShapeNode(circleOfRadius: node.size.width)
        blackCircle.fillColor = .black
        
         
         // 設定黑色框框的位置，這裡以場景中心為例
        blackCircle.position = CGPoint(x: size.width / 2, y: size.height / 2)
         
         // 將黑色框框加入場景
         addChild(blackCircle)
         
         // 創建一個縮放的 SKAction，將黑色框框縮放到一個小點
        let scaleAction = SKAction.scale(to: 25, duration: 0.3)
        let scaleAction2 = SKAction.scale(to: 0.01, duration: 0.1)
         
         // 執行縮放動作
        blackCircle.run(SKAction.sequence([scaleAction,scaleAction2,SKAction.removeFromParent()]))

    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
