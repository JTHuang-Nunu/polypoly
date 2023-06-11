//
//  Canvas.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/6/3.
//

import Foundation
import SpriteKit
import GameplayKit

class MainCanvas: BaseCanvas{
    public let OnDrawLine = Event<CodablePath>()
    public let OnDrawPointer = Event<CGVector>()
    
    
    public var Mode: CanvasMode = CanvasMode.Pointer
    private var line: DrawLine? = nil
    private var pointer: Pointer? = nil
    private var startNode: SKNode? = nil
    private var endPoint: CGPoint? = nil
    
    init(startNode: SKNode) {
        self.startNode = startNode
        super.init()
        self.zPosition = zAxis.Canvas   //set initial zPosition
        // Adjust the size of the canvas to match the screen dimensions
        let screenSize = UIScreen.main.bounds.size
        self.path = UIBezierPath(rect: CGRect(origin: CGPoint.zero, size: screenSize)).cgPath
        self.isUserInteractionEnabled = true
        self.position = CGPoint(x: -screenSize.width/2, y: -screenSize.height/2)
    }
    public func SetMode(mode: CanvasMode){
        Mode = mode
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func startNewPoint(point: CGPoint) {
        super.startNewPoint(point: point)
        switch Mode{
        case .Draw:
            startDraw(point: point)
            break
        case .Pointer:
            startPointer(point: point)
            
        default:
            break
        }
    }
    override func updatePoint(point: CGPoint) {
        super.updatePoint(point: point)
        switch Mode{
        case .Draw:
            assert (line != nil, "line not set")
            line!.UpdateLine(newPoint: point)
            break
        case .Pointer:
            endPoint = point
        }
    }
    override func finishPoint(point: CGPoint) {
        super.finishPoint(point: point)
        switch Mode{
        case .Draw:
            assert (line != nil, "line not set")
            OnDrawLine.Invoke(line!.CodablePath)
            line!.removeFromParent()
            break
        case .Pointer:
            assert (pointer != nil, "pointer not set")
            OnDrawPointer.Invoke(pointer!.GetVector())
            removeAllActions()
            pointer!.removeFromParent()
            pointer = nil
            endPoint = nil
            break
        }
    }
    
    
    private func startDraw(point: CGPoint){
        line = DrawLine(lineWidth: 5)
        line!.SetStartPoint(startPoint: point)
        scene!.addChild(line!)
    }
    private func startPointer(point: CGPoint){
        assert (startNode != nil, "startNode not set")
        endPoint = point
        pointer = Pointer(startPoint: startNode!.position, endPoint: endPoint!)
        scene!.addChild(pointer!)
    }
    
    override func NodeUpdate(_ currentTime: TimeInterval) {
        if let pointer = pointer{
            pointer.UpdatePointer(startPoint: startNode!.position, endPoint: endPoint!)
        }
    }
    
    
}
