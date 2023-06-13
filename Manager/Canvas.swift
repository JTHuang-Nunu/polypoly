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
    case Locate
}
class BaseCanvas: SKShapeNode{
    public var OnStartNewPoint = Event<CGPoint>()
    public var OnUpdateNewPoint = Event<CGPoint>()
    public var OnFinishDrawPoint = Event<CGPoint>()
    
    
    override init() {

        super.init()
        self.zPosition = zAxis.Canvas
        self.strokeColor = .clear
        let screenSize = UIScreen.main.bounds.size
        self.path = UIBezierPath(rect: CGRect(origin: CGPoint.zero, size: screenSize)).cgPath
        self.isUserInteractionEnabled = true
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
    public let OnDrawLocate = Event<CGPoint>()
    
    public var Mode: CanvasMode = CanvasMode.Pointer
    public let PointLimit: CGFloat = 200
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
        self.position = CGPoint(x: 0, y: 0)
    }
    public func SetMode(mode: CanvasMode){
        Mode = mode
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func GetLimitedPoint(point: CGPoint, playerPoint: CGPoint)-> CGPoint{
        let vector = CGVector(dx: point.x - playerPoint.x, dy: point.y - playerPoint.y)
        let length = vector.distance
        if length > PointLimit{
            return CGPoint(x: playerPoint.x + vector.dx/length * PointLimit, y: playerPoint.y + vector.dy/length * PointLimit)
        }
        return point
    }
    
    override func startNewPoint(point: CGPoint) {
        let limitedPoint = GetLimitedPoint(point: point, playerPoint: startNode!.position)
        
        super.startNewPoint(point: limitedPoint)
        switch Mode{
        case .Draw:
            startDraw(point: limitedPoint)
            break
        case .Pointer:
            startPointer(point: limitedPoint)
        case .Locate:
            endPoint = limitedPoint
        
        default:
            break
        }
    }
    override func updatePoint(point: CGPoint) {
        let limitedPoint = GetLimitedPoint(point: point, playerPoint: startNode!.position)
        super.updatePoint(point: limitedPoint)
        switch Mode{
        case .Draw:
            assert (line != nil, "line not set")
            line!.UpdateLine(newPoint: limitedPoint)
            break
        case .Pointer:
            endPoint = limitedPoint
        case .Locate:
            endPoint = limitedPoint
            
        default:
            break
        }
    }
    override func finishPoint(point: CGPoint) {
        let limitedPoint = GetLimitedPoint(point: point, playerPoint: startNode!.position)
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
        case .Locate:
            guard let endPoint = endPoint else {return}
            OnDrawLocate.Invoke(endPoint)
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
        if let endPoint = endPoint{
            let limitedPoint = GetLimitedPoint(point: endPoint, playerPoint: startNode!.position)
            if let pointer = pointer{
                pointer.UpdatePointer(startPoint: startNode!.position, endPoint: limitedPoint)
            }
        }
        
    }
    
    
}
