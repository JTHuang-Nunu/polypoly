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
    init(startPoint: CGPoint, endPoint: CGPoint){
        super.init()
        self.path = GetArrowPath(startPoint: startPoint, endPoint: endPoint)
        self.strokeColor = .blue
    }
    public func UpdatePointer(startPoint: CGPoint, endPoint: CGPoint){
        self.path = GetArrowPath(startPoint: startPoint, endPoint: endPoint)
    }
    private func GetArrowPath(startPoint: CGPoint, endPoint: CGPoint) -> CGMutablePath{
        //endPoint will be the arrow point
        let path = CGMutablePath()
        
        let lineAngle = atan2(endPoint.y - startPoint.y, endPoint.x - startPoint.x)
        
        let arrowPoint = endPoint
        let arrowLeftPoint = CGPoint(x: endPoint.x - arrowLength * cos(lineAngle - arrawAngle), y: endPoint.y - arrowLength * sin(lineAngle - arrawAngle))
        let arrowRightPoint = CGPoint(x: endPoint.x - arrowLength * cos(lineAngle + arrawAngle), y: endPoint.y - arrowLength * sin(lineAngle + arrawAngle))
        path.move(to: startPoint)
        path.addDashLine(to: arrowPoint, dashLen: 5, gapLen: 5, startAt: 0)
        path.addLine(to: arrowLeftPoint)
        path.move(to: arrowPoint)
        path.addLine(to: arrowRightPoint)
        return path
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CGMutablePath {
    func addDashLine(to point: CGPoint, dashLen: CGFloat, gapLen: CGFloat, startAt: CGFloat) {
        let lineLength = sqrt(pow(point.x - currentPoint.x, 2) + pow(point.y - currentPoint.y, 2))
        let dashCount = Int(lineLength / (dashLen + gapLen))
        let dash = dashLen / (dashLen + gapLen)
        let gap = gapLen / (dashLen + gapLen)
        
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
