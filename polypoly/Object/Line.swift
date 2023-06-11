////
////  Line.swift
////  polypoly
////
////  Created by mac03 on 2023/5/3.
////
//
import UIKit
import SpriteKit

class DrawingLine: SKShapeNode {

    var startPoint: CGPoint
    var endPoint: CGPoint
    var linePath: CGMutablePath
    var Width: CGFloat
    //When line health point is 0, line will be removed
    var lineCurrHp: CGFloat
    var lineMaxHp: CGFloat
    
    init(startPoint: CGPoint, endPoint: CGPoint, lineWidth: CGFloat, hp: CGFloat) {
        self.Width = lineWidth
        self.lineMaxHp = hp
        self.lineCurrHp = hp
        self.startPoint = startPoint
        self.endPoint = endPoint
        self.linePath = CGMutablePath()
        super.init()
        self._setupBody()
    }
    init(startPoint: CGPoint, lineWidth: CGFloat, hp: CGFloat) {
        self.Width = lineWidth
        self.lineMaxHp = hp
        self.lineCurrHp = hp
        self.startPoint = startPoint
        self.endPoint = CGPoint()
        self.linePath = CGMutablePath()
        super.init()
        self._setupBody()
    }
    
    internal func movePath(toPoint: CGPoint){
        linePath.addLine(to: toPoint)
        self.path = linePath
    }
    internal func endDrawing(){
        //.closeSubpath() is *line endPoint to startPoint*
//        linePath.closeSubpath()
//        self.path = linePath
        self.physicsBody = SKPhysicsBody(edgeChainFrom: linePath)
    }
    internal func updateLineHp(){
        if lineCurrHp > 1{
            lineCurrHp =  lineCurrHp - 1
            print("lineCurrHp", lineCurrHp)
            self.lineWidth = self.Width * (lineCurrHp/lineMaxHp)
        }
        else{
            self.removeFromParent()
        }
    }
    private func _setupBody(){
        linePath.move(to: startPoint)
        self.name = "drawingLine"
        self.path = linePath
        self.strokeColor = .red
        self.fillColor = .black
        self.lineWidth = Width

//        self.physicsBody = SKPhysicsBody(edgeChainFrom: linePath)
        self.physicsBody?.categoryBitMask = PhysicsCategory.Line
        self.physicsBody?.collisionBitMask = PhysicsCategory.Ball
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Ball
//        self.physicsBody?.friction = 0.2
//        self.physicsBody?.restitution = 1.0
//        self.physicsBody?.linearDamping = 0.0
//        self.physicsBody?.angularDamping = 0.0
//        self.physicsBody?.affectedByGravity = false
//        self.physicsBody?.isDynamic = false
    }
    


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class DrawLine: SKShapeNode {

    private var linePath: CGMutablePath
    private var codablePath: CodablePath
    
    init(lineWidth: CGFloat) {
        self.linePath = CGMutablePath()
        codablePath = polypoly.CodablePath(PointList: [])
        super.init()
        self.strokeColor = .blue
        self.lineWidth = lineWidth
        
    }
    public func SetStartPoint(startPoint: CGPoint){
        linePath.move(to: startPoint)
        codablePath.PointList.append(startPoint)
        self.path = linePath
    }
    
    public func UpdateLine(newPoint: CGPoint){
        linePath.addLine(to: newPoint)
        codablePath.PointList.append(newPoint)
        self.path = linePath
    }
    
    public var CodablePath: CodablePath{
        get{
            return codablePath
        }
    }
    


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
