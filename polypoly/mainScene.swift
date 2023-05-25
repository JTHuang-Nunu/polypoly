//
//  mainScene.swift
//  polypoly
//
//  Created by mac03 on 2023/4/30.
//

import SpriteKit
import Foundation

class MainScene: SKScene, SKPhysicsContactDelegate {
    var screenCenter: CGPoint!
    
//    var player1Node: SKSpriteNode!
    var arrowNode: Arrow!
    var resetButton: SKShapeNode!
    var isDragging = false
    var isDrawing = false
    var startPoint: CGPoint = .zero
    
    var rect: SKShapeNode!
    var lineNode: DrawingLine!
    var linePath: CGMutablePath!
    var powerBar: PowerBar!
    var timer: Timer?

    var player1: CharacterModel!
    var player2: CharacterModel!
    var player1Node: SKSpriteNode!
    var player2Node: SKSpriteNode!
    struct PlayerPosition {
        private static let offset: CGFloat = 200
        static var p1: CGPoint {
            let x = UIScreen.main.bounds.minX + offset
            let y = UIScreen.main.bounds.midY
            return CGPoint(x: x, y: y)
        }
        static var p2: CGPoint {
            let x = UIScreen.main.bounds.maxX - offset
            let y = UIScreen.main.bounds.midY
            return CGPoint(x: x, y: y)
        }
    }

    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        screenCenter = CGPoint(x: self.frame.midX, y: self.frame.midY)
        createScene()
        createResetButton()
        
        //create xy axis
        rect = SKShapeNode(rect: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        rect.strokeColor = .black
        rect.position = screenCenter
        addChild(rect)
        
        // create player1's Ball
//        self.player1 = CharacterModel(ID: 999, position: screenCenter)
        self.player1 = CharacterModel(ID: 999, position: PlayerPosition.p1)
        self.player2 = CharacterModel(ID: 111, position: PlayerPosition.p2)
        player1Node = player1.node
        player2Node = player2.node
        addChild(player1.node)
//        addChild(player2Node)
        
        // create Arrow
        arrowNode = Arrow()
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
            if player1Node.contains(location) {
                isDragging = true
                arrowNode.updateArrow(start: location)
            }
            //resetButton(red btn) is touched
            if resetButton.contains(location) {
                powerBar.power = powerBar.maxPower
                player1Node.removeFromParent()
                player1Node = Ball()
                player1Node.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
                addChild(player1Node)
            }
            //scene is touched
            else{
                if powerBar.power >= 10{ //
                    isDrawing = true
                }
                
                lineNode = DrawingLine(startPoint: touch.location(in: self),lineWidth: 10, hp: 3)
                self.addChild(lineNode)
            }
            
        }
    }
    var lastTouchLocation: CGPoint?
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isDragging {
            if let touch = touches.first {
                arrowNode.updateArrow(current: touch.location(in: self), objectNode: player1Node)
            }
        }
        
        else if isDrawing{
            if let touch = touches.first {
                //get drawing distance, then consume power
                if let lastTouchLocation = lastTouchLocation {
                    let currentTouchLocation = touch.location(in: self)
                    let distance = hypot(currentTouchLocation.x - lastTouchLocation.x, currentTouchLocation.y - lastTouchLocation.y)
                    powerBar.power = powerBar.power - distance * 0.1
                }
                lineNode.movePath(toPoint: touch.location(in: self))
                
                lastTouchLocation = touch.location(in: self) //record the last Location
                
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
            let impulse = arrowNode.getImpulse()
            player1Node.physicsBody?.applyImpulse(impulse)
            arrowNode.xScale = 0
        }
        else if isDrawing{
            isDrawing = false
            print("drew")
            lineNode.endDrawing()
        }
    }
    
        override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
            print("Touches were Cancelled")
        }
    
    // Stoping the ballNode when speed less than 1
    override func update(_ currentTime: TimeInterval) {
        if let physicsBody = player1Node.physicsBody {
            let speed = sqrt(physicsBody.velocity.dx*physicsBody.velocity.dx + physicsBody.velocity.dy*physicsBody.velocity.dy)
            if speed < 1 { //when speed < 1, stop movement
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
        // set Background
        let bgd = Background(image: "marble", position: screenCenter, rotate: 1.57)
        addChild(bgd)

        // set Gravity direction to Z
        physicsWorld.gravity = CGVector(dx: 0.0, dy: 0.0)
        
        // set Wall
        let wall = Wall(size: self.size,position: screenCenter)
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


