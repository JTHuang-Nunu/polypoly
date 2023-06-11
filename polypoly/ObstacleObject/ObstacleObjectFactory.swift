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
    public static var shared = ObstacleObejctFactory()
    func create(type: ObstacleObejctType, position: CGPoint, path: CGPath?) -> ObstacleObejct?{
        switch type {
        case .Building:
            return BuildingObstacle(position: position)
        case .DrawObstacle:
            guard let path = path else {return nil}
            return DrawObstacle(position: position, path: path)
        }
    }
}