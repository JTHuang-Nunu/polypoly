//
//  CGextension.swift
//  polypoly
//
//  Created by mac03 on 2023/6/2.
//

import Foundation
import SpriteKit

extension CGSize {
    static func +(lhs: CGSize, rhs: CGSize) -> CGSize {
        return CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
    }
    
    static func -(lhs: CGSize, rhs: CGSize) -> CGSize {
        return CGSize(width: lhs.width - rhs.width, height: lhs.height - rhs.height)
    }
}
    
extension CGPoint {
    func distance(to point: CGPoint) -> CGFloat {
        let dx = point.x - x
        let dy = point.y - y
        return sqrt(dx*dx + dy*dy)
    }
    
    init(_ x: CGFloat, _ y: CGFloat) {
        self.init(x: x, y: y)
    }
    
    static func +(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    static func -(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
    static func += (left: inout CGPoint, right: CGPoint) {
        left.x += right.x
        left.y += right.y
    }
}
extension CGRect {
    
    init(center: CGPoint, size: CGSize) {
        let origin = CGPoint(x: center.x - size.width / 2, y: center.y - size.height / 2)
        self.init(origin: origin, size: size)
    }
    
    init(center: CGPoint, width: CGFloat, height: CGFloat) {
        let origin = CGPoint(x: center.x - width / 2, y: center.y - height / 2)
        self.init(origin: origin, size: CGSize(width: width, height: height))
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

extension CGPoint: Oppositable{
    var opposite: CGPoint{
        return CGPoint(x: -x, y: -y)
    }
}
