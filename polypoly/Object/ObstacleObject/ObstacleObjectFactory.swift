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
    case Trap
    case BlackHole
}

class ObstacleObejctFactory {
    var OnCreateObstacle: Event<SKNode> = Event<SKNode>()
    init(){
        
    }

    public static var shared = ObstacleObejctFactory()
    func create(type: ObstacleObejctType, position: CGPoint, path: CGPath?) -> ObstacleObejct?{
        //version 1
        switch type {
        case .Building:
            let t = BuildingObstacle(position: position)
            
            return BuildingObstacle(position: position)
        case .DrawObstacle:
            guard let path = path else {return nil}
            return DrawObstacle(position: position, path: path)
        case .Trap:
            return Trap(position: position)
        case .BlackHole:
            return BlackHole(position: position)
        }
//        //version2
//        var object: (any ObservableObject)? = nil
//        switch type {
//        case .Building:
//            object =  BuildingObstacle(position: position) as! ObservableObject
//        case .DrawObstacle:
//            guard let path = path else {return nil}
//            return DrawObstacle(position: position, path: path)
//        case .Trap:
//            return Trap(position: position)
//        case .BlackHole:
//            return BlackHole(position: position)
//        }
//
//        e
//        return object
    }
}
