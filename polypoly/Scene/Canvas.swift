//
//  Canvas.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/6/3.
//

import Foundation
import SpriteKit
import GameplayKit

public enum CanvasMode{
    case Draw
    case Pointer
}
class BaseCanvas: SKShapeNode{
    public var OnStartNewPoint = Event<CGPoint>()
    public var OnUpdateNewPoint = Event<CGPoint>()
    public var OnFinishDrawPoint = Event<CGPoint>()
    
    
    override init() {

        super.init()
        self.zPosition = zAxis.Canvas
        let screenSize = UIScreen.main.bounds.size
        self.path = UIBezierPath(rect: CGRect(origin: CGPoint.zero, size: screenSize)).cgPath
        self.isUserInteractionEnabled = true
        self.position = CGPoint(x: -screenSize.width/2, y: -screenSize.height/2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        startNewPoint(point: touches.first!.location(in: scene!))
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        updatePoint(point: touches.first!.location(in: scene!))
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        finishPoint(point: touches.first!.location(in: scene!))
    }
    public func startNewPoint(point: CGPoint){
        OnStartNewPoint.Invoke(point)
    }
    public func updatePoint(point: CGPoint){
        OnUpdateNewPoint.Invoke(point)
    }
    public func finishPoint(point: CGPoint){
        OnFinishDrawPoint.Invoke(point)
    }
}


class Canvas: BaseCanvas{
    public let OnDrawLine = Event<CodablePath>()
    public let OnDrawPointer = Event<CGVector>()
    
    
    public var Mode: CanvasMode = CanvasMode.Pointer
    private var line: DrawLine? = nil
    private var pointer: Pointer? = nil
    private var startNode: SKNode? = nil
    
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
            assert (pointer != nil, "pointer not set")
            assert (startNode != nil, "startNode not set")
            pointer!.UpdatePointer(startPoint: startNode!.position, endPoint: point)
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
            pointer!.removeFromParent()
            OnDrawPointer.Invoke(pointer!.GetVector())
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
        pointer = Pointer(startPoint: startNode!.position, endPoint: point)
        scene!.addChild(pointer!)
    }
    
}
