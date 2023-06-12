//
//  ObjectName.swift
//  polypoly
//
//  Created by mac03 on 2023/6/11.
//

import Foundation
import SpriteKit

enum InteractionObjectType: String {
    case Building
    case DrawObstacle
    case Wall
    case Ball
    
    case Other //
}

class InteractionObjectionName {
    static let Building = "building"
    static let DrawObstacle = "drawObstacle"
    static let Wall = "wall"
    static let Ball = "ball"
}
