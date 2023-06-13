//
//  BlackHole.swift
//  polypoly
//
//  Created by mac03 on 2023/6/13.
//

import Foundation
import SpriteKit

class BlackHole: ObstacleObejct {
    public let OnTrigger = Event<SKNode>()
    let objectName: String = BlackHoleName
    init(position: CGPoint){
        super.init(node: SKShapeNode(circleOfRadius: 30), texture: SKSpriteNode(imageNamed: objectName))
        self.position = position

        self._setupBody()
    }

    private func _setupBody(){
        self.name = objectName
        //node setting
        node.strokeColor = .orange
        node.fillColor = .yellow
        
        //physics setting
        self.physicsBody = SKPhysicsBody(circleOfRadius: 30)
        self.physicsBody?.isDynamic = false
        
        //override super's physicsbody
        super.physicsBody?.collisionBitMask = .zero
        super.physicsBody?.contactTestBitMask = PhysicsCategory.Ball
        
        //health point setting
        _healthManager.initHP(maxHP: 1)
        //explosion animation setting
        OnObjectDied += runExplosionAnimation
    }
    
    func runExplosionAnimation(node: SKNode){
        guard let object = AnimationFactory.shared.create(type: .explosionByTrap, position: self.position, node: nil).play() else {return}
        node.parent?.addChild(object)
        OnTrigger.Invoke(node)
        //good
//        let object = AnimationFactory.shared.create(type: .explosionByTrap, position: self.position, node: nil)
//        node.parent?.addChild(object as! SKNode)
//
//        node.run(SKAction.sequence([
//            SKAction.run{ [self] in object.play()},
//            SKAction.run{
//                let trap = node as! ObstacleObejct
//                trap.texture?.removeFromParent()},
////            SKAction.wait(forDuration: 2) //waiting animation end
//        ])
//            ,completion: { [self] in OnTrigger.Invoke(node)})
////        node.parent?.addChild(<#T##node: SKNode##SKNode#>)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
