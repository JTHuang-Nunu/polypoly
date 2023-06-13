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
    let radius:CGFloat = 30
    init(position: CGPoint){
        super.init(node: SKShapeNode(circleOfRadius: radius), texture: SKSpriteNode(imageNamed: objectName))
        texture!.size = CGSize(width: radius, height: radius)
        self.position = position

        self._setupBody()
    }

    private func _setupBody(){
        self.name = objectName
        //node setting
        node.strokeColor = .clear
//        node.fillColor = .yellow
        
        //physics setting
        self.physicsBody = SKPhysicsBody(circleOfRadius: 10)
        self.physicsBody?.isDynamic = false
        
        //override super's physicsbody
//        super.physicsBody?.collisionBitMask = .zero
        self.physicsBody?.categoryBitMask = PhysicsCategory.BlackHole
        super.physicsBody?.contactTestBitMask = PhysicsCategory.Ball
        
        //health point setting
        _healthManager.initHP(maxHP: 1)
        //explosion animation setting
        OnObjectDied += runBlackHoleAnimation
        //remove self
        OnTrigger += removeSelf
        let rotation = SKAction.rotate(byAngle: CGFloat.pi * 2, duration: 3.5)
        let repeatRotation = SKAction.repeatForever(rotation)
        node.run(repeatRotation)

        run(SKAction.repeatForever(rotation))
    }
    
    func runBlackHoleAnimation(node: SKNode){
        guard let object = AnimationFactory.shared.create(type: .blackHole, position: self.position, node: nil).play() else {return}
        node.parent?.addChild(object)
        OnTrigger.Invoke(node)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
