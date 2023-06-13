//
//  GoalLineInteraction.swift
//  polypoly
//
//  Created by mac03 on 2023/6/14.
//

import Foundation
import SpriteKit

class GoalLineInteraction {
    static func handleTwoCollision(goalLine: GoalLine, anotherNodeType: InteractionObjectType, contact: SKPhysicsContact) {
        switch anotherNodeType{
        case .Ball:
            let soccerName = SoccerName
            if let nodeA = contact.bodyA.node?.name, let nodeB = contact.bodyB.node?.name{
                if(nodeA == soccerName || nodeB == soccerName){
                    goalLine.OnGoal.Invoke(())
                }
            }
            
            
        default:
            break
        }
    }
}
