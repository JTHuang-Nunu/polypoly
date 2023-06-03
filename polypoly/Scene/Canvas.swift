//
//  Canvas.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/6/3.
//

import Foundation
import SpriteKit

public enum CanvasMode{
    case Draw
    case Pointer
}

class Canvas: SKShapeNode{
    public let OnDrawLine: Event<CGPath> = Event<CGPath>()
    public let OnDrawPointer: Event<CGVector> = Event<CGVector>()
    
    public var Mode: CanvasMode = CanvasMode.Pointer
    var line: DrawLine? = nil
    var pointer: Pointer? = nil
    var pointerStartNode: SKNode? = nil
    
    init(pointerStartNode: SKNode) {
        self.pointerStartNode = pointerStartNode
        super.init()
        
        // Adjust the size of the canvas to match the screen dimensions
        let screenSize = UIScreen.main.bounds.size
        self.path = UIBezierPath(rect: CGRect(origin: CGPoint.zero, size: screenSize)).cgPath
        self.isUserInteractionEnabled = true
        self.position = CGPoint(x: -screenSize.width/2, y: -screenSize.height/2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchBegin(point: touches.first!.location(in: scene!))
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchMove(point: touches.first!.location(in: scene!))
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchEnded(point: touches.first!.location(in: scene!))
    }
    private func touchBegin(point: CGPoint){
        switch Mode{
        case .Draw:
            line = DrawLine(lineWidth: 5)
            line!.SetStartPoint(startPoint: point)
            scene!.addChild(line!)
            break
        case .Pointer:
            pointer = Pointer(startPoint: pointerStartNode!.position, endPoint: point)
            scene!.addChild(pointer!)
            break
        }
    }
    private func touchMove(point: CGPoint){
        switch Mode{
        case .Draw:
            line!.UpdateLine(newPoint: point)
            break
        case .Pointer:
            pointer!.UpdatePointer(startPoint: pointerStartNode!.position, endPoint: point)
            break
        }
    }
    private func touchEnded(point: CGPoint){
        switch Mode{
        case .Draw:
            self.OnDrawLine.Invoke(line!.path!)
            line!.removeFromParent()
            break
        case .Pointer:
            let vector = CGVector(dx: point.x - pointerStartNode!.position.x, dy: point.y - pointerStartNode!.position.y)
            self.OnDrawPointer.Invoke(vector)
            pointer!.removeFromParent()
            break
        }
    }


    
}
