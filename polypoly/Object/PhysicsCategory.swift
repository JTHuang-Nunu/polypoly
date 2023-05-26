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
    static let Line: UInt32 = 0x1 << 3
}
