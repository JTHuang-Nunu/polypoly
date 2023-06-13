//
//  GoalLine.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/6/13.
//

import Foundation
import SpriteKit


class GoalLine: SKShapeNode {
    public let OnGoal = Event<Void>()
    
    override init() {
        super.init()
        self.path = CGPath(rect: CGRect(x: 0, y: 0, width: 50, height: 100), transform: nil)
        fillColor = .blue
        strokeColor = .blue
        physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 10, height: 100))
        physicsBody!.isDynamic = true
        physicsBody!.categoryBitMask = PhysicsCategory.GoalLine
        physicsBody!.collisionBitMask = 0
        physicsBody!.contactTestBitMask = PhysicsCategory.Ball
    }
    
    public func Goal(){
        OnGoal.Invoke(())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
    
    
}
