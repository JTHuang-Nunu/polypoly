//
//  ObjectPosition.swift
//  polypoly
//
//  Created by mac03 on 2023/6/4.
//

import Foundation
import UIKit

class ObjectPosition {
    // locate by UIScreen
    private static let halfX: CGFloat = UIScreen.main.bounds.midX
    private static let halfY: CGFloat = UIScreen.main.bounds.midY
    static let SkillBlock = CGPoint(x: -halfX + 100, y: -halfY + 50)
    static let PowerBar =  CGPoint(x: 0, y: -halfY+50)
    static let BoundWall = CGPoint(x: 0, y: 0)
    static let Center = CGPoint(x: 0, y: 0)
}
