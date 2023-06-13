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
    case Trap
    case Explosion
    case GoalLine
    case Other //
}

class InteractionController:SKNode, SKPhysicsContactDelegate{
//    var contact: CGVector? = nil
    func didBegin(_ contact: SKPhysicsContact) {
//        contact = contact.collisionImpulse
        if let nodeA = contact.bodyA.node, let nodeB = contact.bodyB.node{
//            var nodesName = [String]()
//            if let nodeA = contact.bodyA.node ,let nodeB = contact.bodyB.node{
//                nodesName.append(nodeA.name!)
//                nodesName.append(nodeB.name!)
//            }
            let nodeAType = judgeDataType(node: nodeA)
            let nodeBType = judgeDataType(node: nodeB)
            if (nodeAType == .Other || nodeAType == .Other ){
                print("contact [other] type")
            }
            runInteraction(node: nodeA, nodeType: nodeAType, anotherType: nodeBType, contact: contact)
            runInteraction(node: nodeB, nodeType: nodeBType, anotherType: nodeAType, contact: contact)
        }
    }
    //========================================================
    func runInteraction(node: SKNode, nodeType: InteractionObjectType, anotherType: InteractionObjectType, contact: SKPhysicsContact){
        switch nodeType {
        case .Building:
            BuildingInteraction.handleTwoCollision(Building: node as! BuildingObstacle, anotherNodeType: anotherType, contact: contact)
        case .DrawObstacle:
            DrawObstacleInteraction.handleTwoCollision(DrawObstacle: node as! DrawObstacle, anotherNodeType: anotherType, contact: contact)
        case .Wall:
            WallInteraction.handleTwoCollision(Wall: node as! Wall, anotherNodeType: anotherType, contact: contact)
        case .Ball:
            BallInteraction.handleTwoCollision(ball: node as! Ball, anotherNodeType: anotherType, contact: contact)
        case .Trap:
            TrapInteraction.handleTwoCollision(Trap: node as! Trap, anotherNodeType: anotherType, contact: contact)
        case .Explosion: //it isn't object, don't need do any handle
            break
        case .GoalLine:
            (node as! GoalLine).Goal()
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
        if node is Trap{
            return InteractionObjectType.Trap
        }
        if node is ExplosionByTrap{
            return InteractionObjectType.Explosion
        }
        if node is GoalLine{
            return InteractionObjectType.Other
        }
        return InteractionObjectType.Other
    }
}
