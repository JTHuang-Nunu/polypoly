//
//  Arrow.swift
//  polypoly
//
//  Created by mac03 on 2023/5/3.
//

import UIKit
import SpriteKit

class Arrow: SKShapeNode {
    private var arrowContour: CGMutablePath?
    internal var startPoint: CGPoint = .zero
    private var currPoint: CGPoint = .zero
    private var direction: CGVector = .zero
    private var scale:CGFloat = .zero {
        didSet{
            self.xScale = scale
            self.yScale = scale
        }
    }
    
    override init() {
        super.init()
        self.arrowContour = drawContour()
        self._setupoBody()
    }
    
    internal func updateArrow(start: CGPoint){ //touch begin
        startPoint = start
    }
    internal func updateArrow(current: CGPoint, objectNode: SKSpriteNode) { //touche move
        //--Turn around the ball--
        //get touch slope to set arrow's angle
        currPoint = current
        let distance = startPoint.distance(to: current)
        direction = CGVector(dx: currPoint.x - startPoint.x, dy: currPoint.y - startPoint.y)
        let angle = direction.angle
        self.zRotation = angle
        // turn along the circumference
        let radius = objectNode.size.width/2    //ball radius
        self.position = CGPoint(x: objectNode.frame.midX + radius*CGFloat(cos(angle)),
                                y: objectNode.frame.midY + radius*CGFloat(sin(angle)))
        
        //--Zoom in by dragging distance--
        scale = distance / 100
//        (self.xScale, self.yScale) = (scale, scale)
    }
    
    //--push the ball by the impulse--
    internal func pushBall(player: Character){
        let impulse = getImpulse()
        player.ball.physicsBody?.applyImpulse(impulse)
        self.scale = .zero
    }
    internal func getImpulse() -> CGVector{
        let force = self.scale
        let impulse = CGVector(dx: -direction.dx * force, dy: -direction.dy * force)
        initVariable()
        return impulse
    }
    //--------------------------------
    
    
    

    
    private func _setupoBody(){
        self.name = "arrow"
        self.path = arrowContour
        self.fillColor = .black
        self.lineWidth = 2
    }
    
    private func drawContour() -> CGMutablePath {
        //Using arrowPath to draw Arrow object self
        let path = CGMutablePath()
        let arrowWidth: CGFloat = 10
        let arrowHeight: CGFloat = 70
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: arrowHeight, y: arrowWidth/2))
        path.addLine(to: CGPoint(x: arrowHeight, y: -arrowWidth/2))
        path.closeSubpath()
        return path
    }
    
    private func initVariable(){
        startPoint = .zero
        currPoint = .zero
        direction = .zero
        scale = .zero
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
