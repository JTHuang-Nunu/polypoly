//
//  ObstacleObject.swift
//  polypoly
//
//  Created by mac03 on 2023/6/10.
//

import Foundation
import SpriteKit

enum ObstacleObejctType {
    case Building
    case DrawObstacle
}

class ObstacleObejctFactory {
    func create(type: ObstacleObejctType, position: CGPoint) -> ObstacleObejct{
        switch type {
        case .Building:
            return BuildingObstacle(position: position)
        case .DrawObstacle:
            return DrawObstacle(position: position)
        }
    }
}
