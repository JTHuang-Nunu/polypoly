//
//  BallInteraction.swift
//  polypoly
//
//  Created by mac03 on 2023/6/11.
//

import Foundation
import SpriteKit

class BallInteraction {
    static func handleTwoCollision(ball: Ball, anotherNodeType: InteractionObjectType, contact: SKPhysicsContact) {
        switch anotherNodeType{
        case .Building:
            ball.onInjured.Invoke(1)
            
        case .DrawObstacle:
            ball.onInjured.Invoke(1)
            
        case .Wall: //no action
            break
            
        case .Ball:
            ball.onInjured.Invoke(1)
        
        case .Trap:
            ball.onInjured.Invoke(1)
            ball.
        case .Other: //no action
            break
        }
    }
}
