//
//  Action.swift
//  polypoly
//
//  Created by mac03 on 2023/5/24.
//

import Foundation
import SpriteKit

protocol BallAction {
    var duration: TimeInterval { get }
    
    func run(with node: SKNode, completionHandler: @escaping () -> Void)
}

class RotateAction: BallAction {
    var duration: TimeInterval
    
    init(duration: TimeInterval) {
        self.duration = duration
    }
    
    func run(with node: SKNode, completionHandler: @escaping () -> Void) {
        let rotateAction = SKAction.rotate(byAngle: CGFloat.pi, duration: duration)
        node.run(rotateAction, completion: completionHandler)
    }
}

class ScaleAction: BallAction {
    var duration: TimeInterval
    
    init(duration: TimeInterval) {
        self.duration = duration
    }
    
    func run(with node: SKNode, completionHandler: @escaping () -> Void) {
        let scaleAction = SKAction.scale(by: 2.0, duration: duration)
        node.run(scaleAction, completion: completionHandler)
    }
}

//// 使用範例
//let ballNode = SKShapeNode(circleOfRadius: 10)
//let rotateAction = RotateAction(duration: 2.0)
//rotateAction.run(with: ballNode) {
//    // 球的旋轉動作完成後的處理
//}
//
//let scaleAction = ScaleAction(duration: 1.0)
//scaleAction.run(with: ballNode) {
//    // 球的縮放動作完成後的處理
//}
