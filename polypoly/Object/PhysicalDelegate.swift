//
//  PhysicalDelegate.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/6/11.
//

import Foundation
import SpriteKit

class GlobalPhysicsDelegate: NSObject, SKPhysicsContactDelegate{
    static let shared = GlobalPhysicsDelegate()
    private override init() {}
    
}
