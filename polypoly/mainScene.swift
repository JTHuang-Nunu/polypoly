//
//  mainScene.swift
//  polypoly
//
//  Created by mac03 on 2023/4/30.
//

import SpriteKit
import Foundation
class MainScene: SKScene, SKPhysicsContactDelegate {
    
    var ballNode: SKSpriteNode!
    var arrowNode: SKShapeNode!
    var resetButton: SKShapeNode!
    var isDragging = false
    var isDrawing = false
    var startPoint: CGPoint = .zero
    
    var circle: SKShapeNode!
    var lineNode: DrawingLine!
    var linePath: CGMutablePath!
    var powerBar: PowerBar!
    var timer: Timer?

    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        createScene()
        createResetButton()
        
        circle = SKShapeNode(rect: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        circle.strokeColor = .black
        circle.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        addChild(circle)
        
        
        ballNode = Ball()
        ballNode.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        addChild(ballNode)
        
        // createArrow
        let arrowWidth: CGFloat = 10
        let arrowHeight: CGFloat = 70
        let arrowPath = CGMutablePath()
        arrowPath.move(to: CGPoint(x: 0, y: 0))
        arrowPath.addLine(to: CGPoint(x: arrowHeight, y: arrowWidth/2))
        arrowPath.addLine(to: CGPoint(x: arrowHeight, y: -arrowWidth/2))
        arrowPath.closeSubpath()
        arrowNode = SKShapeNode(path: arrowPath)
        arrowNode.fillColor = .black
        //        arrowNode.strokeColor = .red
        arrowNode.lineWidth = 2
        arrowNode.position = CGPoint(x: frame.midX, y: ballNode.frame.midY)
        //        arrowNode.zRotation =
        addChild(arrowNode)
    }
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody = SKPhysicsBody()
        var secondBody = SKPhysicsBody()

        if contact.bodyA.node?.name == "ball"{
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }
        else{
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        if(firstBody.node?.name == "ball" && secondBody.node?.name == "drawingLine"){
            print("collipse")
            if let drawingLine = secondBody.node as? DrawingLine {
                drawingLine.updateLineHp()
            }
        }
    }
    func didEnd(_ contact: SKPhysicsContact) {
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            //ballNode is touched by finger
            if ballNode.contains(location) {
                isDragging = true
                startPoint = location
            }
            //resetButton(red btn) is touched
            if resetButton.contains(location) {
                powerBar.power = powerBar.maxPower
                ballNode.removeFromParent()
                ballNode = Ball()
                ballNode.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
                addChild(ballNode)
            }
            //scene is touched
            else{
//                let circle = SKShapeNode(circleOfRadius: 10) // 創建圓形節點
//                circle.position = touch.location(in: self) // 設置位置
//                circle.strokeColor = SKColor.red // 設置邊框顏色
//                circle.lineWidth = 2 // 設置邊框寬度
//                circle.fillColor = SKColor.blue // 設置填充顏色
//                circle.physicsBody = SKPhysicsBody(circleOfRadius: 10)
//                circle.physicsBody?.usesPreciseCollisionDetection = true
//                circle.physicsBody?.isDynamic = false
//
//
//                circle.physicsBody?.categoryBitMask = PhysicsCategory.Line
//                circle.physicsBody?.contactTestBitMask = PhysicsCategory.Ball
//                addChild(circle) // 將節點添加到場景中
                
                if powerBar.power >= 10{
                    isDrawing = true
                }
                
                lineNode = DrawingLine(startPoint: touch.location(in: self),lineWidth: 10, hp: 3)
                self.addChild(lineNode)
            }
            
        }
    }
    var lastTouchLocation: CGPoint?
    var totalDistance: CGFloat = 0
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isDragging {
            if let touch = touches.first {
                // get basic info
                let location = touch.location(in: self)
                let distance = startPoint.distance(to: location)
                let direction = CGVector(dx: location.x - startPoint.x, dy: location.y - startPoint.y)
                let angle = direction.angle
                arrowNode.zRotation = angle
                
                // set arrow startpoint from ball, let arrow go around the edge of ball
                let ballRadius = ballNode.size.width/2
                // along the circumference
                arrowNode.position = CGPoint(x: ballNode.frame.midX + ballRadius*CGFloat(cos(angle)),y: ballNode.frame.midY + ballRadius*CGFloat(sin(angle)))
                
                //  arrow zomm by dragging distance
                arrowNode.yScale = distance / 100
                arrowNode.xScale = distance / 100

            }
        }
        else if isDrawing{
            if let touch = touches.first {
                //get drawing distance, then consume power
                if let lastTouchLocation = lastTouchLocation {
                       let currentTouchLocation = touch.location(in: self)
                       let distance = hypot(currentTouchLocation.x - lastTouchLocation.x, currentTouchLocation.y - lastTouchLocation.y)
//                       totalDistance += distance
                    powerBar.power = powerBar.power - distance * 0.1
                }
                lineNode.movePath(toPoint: touch.location(in: self))
                //record the last Location
                lastTouchLocation = touch.location(in: self)
//                print("drawing move")
                
                //if powerBar's power less equal 0
                if powerBar.power <= 0{
                    isDrawing = false
                    print("drew")
                    lineNode.endDrawing()
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isDragging {
            isDragging = false
            let force = arrowNode.xScale * 100
            let direction = CGVector(dx: arrowNode.zRotation.cosine(), dy: arrowNode.zRotation.sine())
            let impulse = CGVector(dx: -direction.dx * force, dy: -direction.dy * force)
            ballNode.physicsBody?.applyImpulse(impulse)
            arrowNode.xScale = 0
        }
        else if isDrawing{
            isDrawing = false
            print("drew")
            lineNode.endDrawing()
        }
    }
    
    //    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    //        if isDragging {
    //            isDragging = false
    //            arrowNode.xScale = 0
    //        }
    //    }
    
    override func update(_ currentTime: TimeInterval) {
        if let physicsBody = ballNode.physicsBody {
            let speed = sqrt(physicsBody.velocity.dx*physicsBody.velocity.dx + physicsBody.velocity.dy*physicsBody.velocity.dy)
            if speed < 1 {
                physicsBody.velocity = CGVector(dx: 0, dy: 0)
                physicsBody.angularVelocity = 0
            }
        }
    }
    func createResetButton(){
        resetButton = SKShapeNode(circleOfRadius: 10)
        resetButton.fillColor = .red
        resetButton.position = CGPoint(x: frame.midX, y: frame.minY+100)
        addChild(resetButton)
    }

    func createScene(){
        let bgd = SKSpriteNode(imageNamed: "marble")
        bgd.zRotation = 1.57
        bgd.size.width = bgd.size.width
        bgd.size.height = bgd.size.height
        bgd.position = CGPoint(x:self.frame.midX, y:self.frame.midY)
        bgd.zPosition = -1
        addChild(bgd)

        // set Gravity direction to Z
        physicsWorld.gravity = CGVector(dx: 0.0, dy: 0.0)
        
        // set Wall
        let wall = Wall(size: self.size)
        wall.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        addChild(wall)
        
        // set powerBar
        powerBar = PowerBar(position: CGPoint(x: self.frame.midX, y: 20),width: 300, height: 30, power: 100)
        addChild(powerBar)
        // add powerBar timer
        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true, block: { [weak self] _ in
                    guard let self = self else { return }
                    self.powerBar.recoveryPower() // update the power bar display
                })
    }
}



extension CGPoint {
    func distance(to point: CGPoint) -> CGFloat {
        let dx = point.x - x
        let dy = point.y - y
        return sqrt(dx*dx + dy*dy)
    }
}

extension CGVector {
    var angle: CGFloat {
        return atan2(dy, dx)
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


