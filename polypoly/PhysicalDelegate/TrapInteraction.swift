//
//  TrapInteraction.swift
//  polypoly
//
//  Created by mac03 on 2023/6/13.
//

import Foundation
import SpriteKit

class TrapInteraction {
    static func handleTwoCollision(Trap: Trap, anotherNodeType: InteractionObjectType, contact: SKPhysicsContact) {
        switch anotherNodeType{
        case .Ball:
            Trap.onInjured.Invoke(1) //when Trap health == 0, health manager will trigger explosion animation
        default:
            break
        }
    }
}
