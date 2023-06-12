//
//  BuildingInteraction.swift
//  polypoly
//
//  Created by mac03 on 2023/6/12.
//

import Foundation

class BuildingInteraction {
    static func handleTwoCollision(Building: BuildingObstacle, anotherNodeType: InteractionObjectType, contact: SKPhysicsContact) {
        switch anotherNodeType{
        case .Ball:
            Building.onInjured.Invoke(1)
        default:
            break
        }
    }
}
