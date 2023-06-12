//
//  PhysicalDelegate.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/6/11.
//

import Foundation
import SpriteKit

class GlobalPhysicsDelegate: NSObject, SKPhysicsContactDelegate {
//    static let shared = GlobalPhysicsDelegate()
    
    init(in scene: SKScene) {
        super.init()
        setupPhysicsWorld(in: scene)
    }
    
    func setupPhysicsWorld(in scene: SKScene) {
        scene.physicsWorld.contactDelegate = self
        scene.physicsWorld.gravity = CGVector(dx: 0.0, dy: 0.0)
    }
    
}
