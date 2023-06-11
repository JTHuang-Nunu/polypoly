//
//  CGextension.swift
//  polypoly
//
//  Created by mac03 on 2023/6/2.
//

import Foundation
import SpriteKit

extension CGPoint {
    func distance(to point: CGPoint) -> CGFloat {
        let dx = point.x - x
        let dy = point.y - y
        return sqrt(dx*dx + dy*dy)
    }
    static func += (left: inout CGPoint, right: CGPoint){
        left = CGPoint(x: left.x + right.x, y: left.y + right.y)
    }
    static func + (left: CGPoint, right: CGPoint) -> CGPoint{
        return CGPoint(x: left.x + right.x, y: left.y + right.y)
    }
    static func - (left: CGPoint, right: CGPoint) -> CGPoint{
        return CGPoint(x: left.x - right.x, y: left.y - right.y)
    }
}

extension CGVector {
    var distance: CGFloat{
        return sqrt((dx*dx) + (dy*dy))
    }
    
    var angle: CGFloat {
        return atan2(dy, dx)
    }
    
    static func / (vector: CGVector, disvisor: CGFloat) -> CGVector{
        return CGVector(dx: vector.dx / disvisor, dy: vector.dy / disvisor)
    }
    static func * (vector: CGVector, disvisor: CGFloat) -> CGVector{
        return CGVector(dx: vector.dx * disvisor, dy: vector.dy * disvisor)
    }
}

extension CGFloat {
    func cosine() -> CGFloat {
        return CGFloat(cos(Double(self)))
    }

    func sine() -> CGFloat {
        return CGFloat(sin(Double(self)))
    }
}


func deg2rad(degree: CGFloat)-> Double {
    let angle: Double = Double(degree) // in degrees
    let radians = angle * Double.pi / 180
    return radians
}


extension CGVector: Oppositable{
    var opposite: CGVector{
        return CGVector(dx: -dx, dy: -dy)
    }
}

extension SKNode{
    func _update(_ currentTime: TimeInterval){
        NodeUpdate(currentTime)
        for child in children{
            child._update(currentTime)
        }
    }
    @objc public func NodeUpdate(_ currentTime: TimeInterval){
        
    }
}

