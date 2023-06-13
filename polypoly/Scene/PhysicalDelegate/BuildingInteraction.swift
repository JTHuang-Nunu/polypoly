//
//  BuildingInteraction.swift
//  polypoly
//
//  Created by mac03 on 2023/6/12.
//

import Foundation
import SpriteKit

class BuildingInteraction {
    static func handleTwoCollision(building: BuildingObstacle, anotherNodeType: InteractionObjectType, contact: SKPhysicsContact) {
        switch anotherNodeType{
        case .Ball:
            building.onInjured.Invoke(1)
        case .Explosion:
            building.onInjured.Invoke(1)
        default:
            break
        }
    }
}
