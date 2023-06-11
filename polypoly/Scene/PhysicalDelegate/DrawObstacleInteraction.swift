//
//  DrawObstacleInteraction.swift
//  polypoly
//
//  Created by mac03 on 2023/6/12.
//

import Foundation
import SpriteKit

class DrawObstacleInteraction {
    static func handleTwoCollision(DrawObstacle: DrawObstacle, anotherNodeType: InteractionObjectType) {
        switch anotherNodeType{
        case .Building:
            break
        case .DrawObstacle:
            break
        case .Wall:
            break
        case .Ball:
            DrawObstacle.onInjured.Invoke(1)
        case .Other:
            break
        }
    }
}
