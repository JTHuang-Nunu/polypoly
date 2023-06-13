//
//  PhysicsCategory.swift
//  polypoly
//
//  Created by mac03 on 2023/4/30.
//

import Foundation

struct PhysicsCategory {
    static let Ball: UInt32 = 0x1 << 0
    static let Wall: UInt32 = 0x1 << 1
    static let Boundary: UInt32 = 0x1 << 2
//    static let Line: UInt32 = 0x1 << 3  //abandon
    static let Obstacle: UInt32 = 0x1 << 4
    static let Explosion: UInt32 = 0x1 << 5
    static let GoalLine: UInt32 = 0x1 << 6
}
