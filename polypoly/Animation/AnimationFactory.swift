//
//  AnimationFactory.swift
//  polypoly
//
//  Created by mac03 on 2023/6/10.
//

import Foundation
import SpriteKit

enum AnimationType{
    case explosion
    case explosion2
    case blackHole
    case shake
}

class AnimationFactory {
//    func create(type: AnimationType) -> AnimationProtocol {
//        switch type {
//        case .explosion:
//            return ExplosionAnimation()
//        case .explosion2:
//            return ExplosionAnimation2()
//        case .blackHole:
//            return BlackHole()
//        }
//    }
    
    func create(type: AnimationType, position: CGPoint, node: SKNode?) -> AnimationProtocol {
        switch type {
        case .explosion:
            let animation = ExplosionAnimation()
            animation.position = position
            return animation
        case .explosion2:
            let animation = ExplosionAnimation2()
            animation.position = position
            return animation
        case .blackHole:
            let animation = BlackHole()
            animation.position = position
            return animation
        case .shake:
            let animation = ObjectShakeAnimation(Inode: node!)
            animation.position = position
            return animation
        }
    }
}
