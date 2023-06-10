//
//  ObjectShakeAnimation.swift
//  polypoly
//
//  Created by mac03 on 2023/6/11.
//

import Foundation
import SpriteKit

class ObjectShakeAnimation: SKNode, AnimationProtocol {
    var node = SKSpriteNode()
    var tmp = SKNode()
    var textures: [SKTexture]?
    override init(){
        
        super.init()
    }
    init(Inode: SKNode){
        self.tmp = Inode
        super.init()
    }
    public func play() -> SKNode?{
        let duration: CGFloat = 5
        let numberOfShakes = Int(duration / 0.04)
        let amplitudeX: CGFloat = 10.0
        let amplitudeY: CGFloat = 5.0
        var actions = [SKAction]()
        
        for _ in 0..<numberOfShakes {
            let dx = CGFloat.random(in: -amplitudeX...amplitudeX)
            let dy = CGFloat.random(in: -amplitudeY...amplitudeY)
            let shakeAction = SKAction.moveBy(x: dx, y: dy, duration: 0.02)
            actions.append(shakeAction)
            actions.append(shakeAction.reversed())
        }
        
        let shakeSequence = SKAction.sequence(actions)
        tmp.run(shakeSequence)

        return self
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
