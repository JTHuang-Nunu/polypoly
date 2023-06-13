//
//  DrawObstacleInteraction.swift
//  polypoly
//
//  Created by mac03 on 2023/6/12.
//

import Foundation
import SpriteKit

class DrawObstacleInteraction {
    static func handleTwoCollision(DrawObstacle: DrawObstacle, anotherNodeType: InteractionObjectType, contact: SKPhysicsContact) {
        switch anotherNodeType{
        case .Ball:
            DrawObstacle.onInjured.Invoke(1)
        case .Explosion:
            DrawObstacle.onInjured.Invoke(1)
        default:
            break
        }
    }
}
