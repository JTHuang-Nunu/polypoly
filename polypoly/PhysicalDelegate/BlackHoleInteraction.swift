//
//  BlackHoleInteraction.swift
//  polypoly
//
//  Created by mac03 on 2023/6/13.
//

import Foundation
import SpriteKit

class BlackHoleInteraction {
    static func handleTwoCollision(blackhole: BlackHole, anotherNodeType: InteractionObjectType, contact: SKPhysicsContact) {
        switch anotherNodeType{
        case .Ball:
            blackhole.onInjured.Invoke(1)
        default:
            break
//        case .DrawObstacle:
//            ball.onInjured.Invoke(1)
//
//        case .Wall: //no action
//            break
//
//        case .Ball:
//            ball.onInjured.Invoke(1)
//
//        case .Trap:
////            ball.onInjured.Invoke(1)
//            break
//        case .Explosion:
//            ball.onInjured.Invoke(3)
//
//        case .Other: //no action
//            break
        }
    }
}
