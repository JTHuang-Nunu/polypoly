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
            
        case .Trap: //碰到陷阱不扣血 由爆炸扣血
            break
            
        case .Explosion:
            ball.onInjured.Invoke(3)
            
        case .BlackHole:
            ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            ball.onInjured.Invoke(PlayerMaxHP)
            
        case .Other: //no action
            break
        }

    }
}
