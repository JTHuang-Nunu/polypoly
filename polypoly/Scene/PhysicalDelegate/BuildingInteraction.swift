//
//  BuildingInteraction.swift
//  polypoly
//
//  Created by mac03 on 2023/6/12.
//

import Foundation

class BuildingInteraction {
    static func handleTwoCollision(Building: BuildingObstacle, anotherNodeType: InteractionObjectType) {
        switch anotherNodeType{
        case .Building:
            break
        case .DrawObstacle:
            break
        case .Wall:
            break
        case .Ball:
            Building.onInjured.Invoke(1)
        case .Other:
            break
        }
    }
}
