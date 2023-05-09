//
//  MPBar.swift
//  polypoly
//
//  Created by mac03 on 2023/5/9.
//

import UIKit
import SpriteKit

//class MPBar: SKShapeNode {
////    var startPoint: CGPoint
////    var endPoint: CGPoint
//    var barWidth: CGFloat
//    var maxMP: CGFloat
//    var currMP: CGFloat
////    var Width: CGFloat
//    init(maxMP: CGFloat, Position: CGPoint, width: CGFloat) {
//        self.maxMP = maxMP
//        self.currMP = maxMP
//        self.barWidth = width
////        self.startPoint = startPoint
////        self.endPoint = endPoint
//        super.init()
//        self._setupBody()
//    }
////    init(startPoint: CGPoint, lineWidth: CGFloat) {
////        self.Width = lineWidth
////        self.startPoint = startPoint
////        self.endPoint = CGPoint()
////        self.linePath = CGMutablePath()
////        super.init()
////        self._setupBody()
////    }
//    
////    internal func movePath(toPoint: CGPoint){
////        linePath.addLine(to: toPoint)
////        self.path = linePath
////    }
////    internal func endDrawing(){
////        self.physicsBody = SKPhysicsBody(edgeChainFrom: linePath)
////    }
//    private func _setupBody(){
//        let bar = CGMutablePath()
//        bar.move(to: startPoint)
//        bar.addLine(to: endPoint)
//        self.path = bar
//        
//        self.strokeColor = .gray
//        self.fillColor = .blue
//        self.lineWidth = 10
//        
//        self.position = CGPoint(x: abs(endPoint.x - startPoint.x)/2, y: abs(endPoint.y-startPoint.y)/2)
//
////        self.physicsBody?.categoryBitMask = PhysicsCategory.Line
////        self.physicsBody?.collisionBitMask = PhysicsCategory.Ball
////        self.physicsBody?.contactTestBitMask = PhysicsCategory.Ball
////        self.physicsBody?.friction = 0.2
////        self.physicsBody?.restitution = 1.0
////        self.physicsBody?.linearDamping = 0.0
////        self.physicsBody?.angularDamping = 0.0
////        self.physicsBody?.affectedByGravity = false
////        self.physicsBody?.isDynamic = false
//    }
//    
//
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}


class PowerBar: SKShapeNode {
    private var width: CGFloat = 0
    private var height: CGFloat = 0
    private var powerBar: SKShapeNode?
    internal var maxPower: CGFloat = 0
    
    var power: CGFloat = 0{
        didSet {
            if power > maxPower {
                power = maxPower
            }
            //if power value is changed, updating powerBar width
            if power > 0 {
                let newWidth = self.width * (power/maxPower)
                self.powerBar?.path =  CGPath(roundedRect: CGRect(x: -self.width/2, y: -self.height/2, width: newWidth, height: self.height), cornerWidth: self.height/2, cornerHeight: self.height/2, transform: nil)
                print("newWidth",newWidth)
            }else if power <= 0{
                power = 0
                self.powerBar?.path =  CGPath(roundedRect: CGRect(x: -self.width/2, y: -self.height/2, width: 0, height: self.height), cornerWidth: self.height/2, cornerHeight: self.height/2, transform: nil)
            }
        }
    }
    
    init(position: CGPoint, width: CGFloat, height: CGFloat, power: CGFloat) {
        super.init()
        self.width = width
        self.height = height
        self.power = power
        self.maxPower = power
//        self.position = position
        // 畫出能量條的背景
        let bgNode = SKShapeNode(rectOf: CGSize(width: self.width, height: self.height), cornerRadius: self.height/2)

        bgNode.fillColor = .gray
        bgNode.lineWidth = 0
        bgNode.position = position
        addChild(bgNode)
        
        // 畫出能量條
        let powerPath = CGPath(roundedRect: CGRect(x: -self.width/2, y: -self.height/2, width: self.width, height: self.height), cornerWidth: self.height/2, cornerHeight: self.height/2, transform: nil)
        let powerNode = SKShapeNode(path: powerPath)
        powerNode.fillColor = .yellow
        powerNode.strokeColor = .white
        powerNode.lineWidth = 0
        powerNode.position = position
        addChild(powerNode)
        self.powerBar = powerNode
    }
    
    internal func recoveryPower(){
        self.power += maxPower/250
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
