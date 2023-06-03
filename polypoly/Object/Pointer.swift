//
//  Pointer.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/6/2.
//

import Foundation
import SpriteKit

class Pointer: SKShapeNode{
    let arrowLength: CGFloat = 20
    let arrawAngle: CGFloat = 20 * CGFloat.pi / 180
    var startPoint: CGPoint
    var endPoint: CGPoint
    var startAt: CGFloat = 0
    let dashLen: CGFloat = 5
    let gapLen: CGFloat = 5
    var useDashLine: Bool
    
    init(startPoint: CGPoint, endPoint: CGPoint, useDashLine: Bool = true){
        self.startPoint = startPoint
        self.endPoint = endPoint
        self.useDashLine = useDashLine
        
        super.init()
        self.path = GetArrowPath(startPoint: startPoint, endPoint: endPoint)
        self.strokeColor = .blue
        setKeepUpdateAction()
    }
    public func UpdatePointer(startPoint: CGPoint, endPoint: CGPoint){
        self.startPoint = startPoint
        self.endPoint = endPoint
        UpdatePointer()
    }
    private func UpdatePointer(){
        self.path = GetArrowPath(startPoint: startPoint, endPoint: endPoint)
    }
    
    private func GetArrowPath(startPoint: CGPoint, endPoint: CGPoint) -> CGMutablePath{
        let path = CGMutablePath()
        
        let lineAngle = atan2(endPoint.y - startPoint.y, endPoint.x - startPoint.x)
        
        let arrowPoint = endPoint
        let arrowLeftPoint = CGPoint(x: endPoint.x - arrowLength * cos(lineAngle - arrawAngle), y: endPoint.y - arrowLength * sin(lineAngle - arrawAngle))
        let arrowRightPoint = CGPoint(x: endPoint.x - arrowLength * cos(lineAngle + arrawAngle), y: endPoint.y - arrowLength * sin(lineAngle + arrawAngle))
        path.move(to: startPoint)
        if useDashLine{
            path.addDashLine(to: arrowPoint, dashLen: 5, gapLen: 5, startAt: startAt)
        }
        else{
            path.addLine(to: arrowPoint)
        }
        path.addLine(to: arrowLeftPoint)
        path.move(to: arrowPoint)
        path.addLine(to: arrowRightPoint)
        return path
    }
    private func setKeepUpdateAction(){
        let updateAction = SKAction.run {
            self.startAt += 0.5
            if self.startAt > self.dashLen + self.gapLen{
                self.startAt = 0
            }
            self.UpdatePointer()
        }
        let waitAction = SKAction.wait(forDuration: 0.01)
        let sequenceAction = SKAction.sequence([updateAction, waitAction])
        let repeatAction = SKAction.repeatForever(sequenceAction)
        self.run(repeatAction)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CGMutablePath {
    func addDashLine(to point: CGPoint, dashLen: CGFloat, gapLen: CGFloat, startAt: CGFloat) {
        let lineLength = sqrt(pow(point.x - currentPoint.x, 2) + pow(point.y - currentPoint.y, 2))
        let dashCount = Int(lineLength / (dashLen + gapLen))
        
        var currentDistance: CGFloat = 0
        let lineAngle = atan2(point.y - currentPoint.y, point.x - currentPoint.x)
        
        var currentPoint = CGPoint(x: currentPoint.x + startAt * cos(lineAngle), y: currentPoint.y + startAt * sin(lineAngle))
        
        
        for _ in 0..<dashCount {
            let nextPoint = CGPoint(x: currentPoint.x + dashLen * cos(lineAngle), y: currentPoint.y + dashLen * sin(lineAngle))
            move(to: currentPoint)
            addLine(to: nextPoint)
            currentPoint = CGPoint(x: currentPoint.x + (dashLen + gapLen) * cos(lineAngle), y: currentPoint.y + (dashLen + gapLen) * sin(lineAngle))
            currentDistance += dashLen + gapLen
        }
        addLine(to: point)
    }
}
