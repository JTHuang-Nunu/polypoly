//
//  InteractionController.swift
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

class InteractionController:SKNode, SKPhysicsContactDelegate{
    func didBegin(_ contact: SKPhysicsContact) {
        if let nodeA = contact.bodyA.node, let nodeB = contact.bodyB.node{
            var nodesName = [String]()
            if let nodeA = contact.bodyA.node ,let nodeB = contact.bodyB.node{
                nodesName.append(nodeA.name!)
                nodesName.append(nodeB.name!)
            }
            let nodeAType = judgeDataType(node: nodeA)
            let nodeBType = judgeDataType(node: nodeB)
            
            runInteraction(node: nodeA, nodeType: nodeAType, anotherType: nodeBType)
            runInteraction(node: nodeB, nodeType: nodeBType, anotherType: nodeAType)
        }
    }
    //========================================================
    func runInteraction(node: SKNode, nodeType: InteractionObjectType, anotherType: InteractionObjectType){
        switch nodeType {
        case .Building:
            BuildingInteraction.handleTwoCollision(Building: node as! BuildingObstacle, anotherNodeType: anotherType)
        case .DrawObstacle:
            DrawObstacleInteraction.handleTwoCollision(DrawObstacle: node as! DrawObstacle, anotherNodeType: anotherType)
        case .Wall:
            WallInteraction.handleTwoCollision(Wall: node as! Wall, anotherNodeType: anotherType)
        case .Ball:
            BallInteraction.handleTwoCollision(ball: node as! Ball, anotherNodeType: anotherType)
        case .Other:
            break
        }
    }
    //========================================================
    func judgeDataType(node: SKNode) -> InteractionObjectType{
        if node is Ball{
            return InteractionObjectType.Ball
        }
        if node is BuildingObstacle{
            return InteractionObjectType.Building
        }
        if node is DrawObstacle{
            return InteractionObjectType.DrawObstacle
        }
        if node is Wall{
            return InteractionObjectType.Wall
        }
        return InteractionObjectType.Other
    }
}
