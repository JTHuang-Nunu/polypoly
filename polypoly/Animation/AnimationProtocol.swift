//
//  AnimationProtocol.swift
//  polypoly
//
//  Created by mac03 on 2023/6/10.
//

import Foundation
import SpriteKit

protocol AnimationProtocol{
    var node: SKSpriteNode { get}
    func play() -> SKNode?
}
