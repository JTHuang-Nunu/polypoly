//
//  TrapInteraction.swift
//  polypoly
//
//  Created by mac03 on 2023/6/13.
//

import Foundation
import SpriteKit

class TrapInteraction {
    static func handleTwoCollision(Trap: Trap, anotherNodeType: InteractionObjectType, contact: SKPhysicsContact, contact: SKPhysicsContact) {
        switch anotherNodeType{
        case .Ball:
            Trap.onInjured.Invoke(1)
            
        default:
            break
        }
    }
}
