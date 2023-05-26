//
//  mainScene.swift
//  polypoly
//
//  Created by mac03 on 2023/4/30.
//

import SpriteKit
import Foundation

class MainScene: SKScene, SKPhysicsContactDelegate {
    private var screenCenter: CGPoint!  //Locating my screen center for char and other object

    var arrowNode: Arrow!
    var resetButton: SKShapeNode!
    var isDragging = false
    var isDrawing = false
    var startPoint: CGPoint = .zero
    
    var rect: SKShapeNode!
    var powerBar: PowerBar!
    var timer: Timer?
    
    //player variable
    var uuidDictionary = [UUID: String]()
    var player1: Character!
    var player2: Character!
    var id1: UUID!
    var id2: UUID!
    var playerActionTmp: PlayerAction!
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
    func createPlayer(playerNumber: Int){ //define two plater
        //todo: now is tmp func, need to complete
//        for i in 0..playerNumber {
//            let id = UUID() //system assign a random string
//            uuidDictionary[i] = id
//        }
        id1 = UUID()
        self.player1 = Character(characterModelID: id1, position: PlayerPosition.p1)
        id2 = UUID()
        if(id1 == id2){
            print("##two player have same id")
        }else{
            print("##diffent id")
        }
        self.player2 = Character(characterModelID: id1, position: PlayerPosition.p2)
        self.addChild(player1.ball)
        self.addChild(player2.ball)
        
        
        playerActionTmp = PlayerAction(
            CharacterModelID: UUID(),
            ActionType: .ChooseAbility,
            AbilityID: 0,
            ActionTime: Date()
        )

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
        createPlayer(playerNumber: 2)
        
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
            //[ballNode]
            if player1.ball.contains(location) {
                isDragging = true
                arrowNode.updateArrow(start: location)
            }
            //resetButton(red btn) is touched
            if resetButton.contains(location) {
                powerBar.power = powerBar.maxPower
                player1.ball.removeFromParent()
                player1.ball = Ball()
                player1.ball.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
                addChild(player1.ball)
            }
            //[scene] is touched, exclude ball
            else{
                if powerBar.power >= 10{ //
                    isDrawing = true
                }
                player1.draw(status: .begin, point: touch.location(in: self))
                playerActionTmp.ActionType = .Draw(.begin)
                player2.DoAction(action: playerActionTmp, point: touch.location(in: self),impulse: nil)
                addChild(player1.lineList.last!)
            }
            
        }
    }
    //todo: set todo.md
    var lastTouchLocation: CGPoint?
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isDragging {
            if let touch = touches.first {
                arrowNode.updateArrow(current: touch.location(in: self), objectNode: player1.ball)
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
                player1.draw(status: .move, point: touch.location(in: self))
                playerActionTmp.ActionType = .Draw(.move)
                player2.DoAction(action: playerActionTmp, point: touch.location(in: self),impulse: nil)
                lastTouchLocation = touch.location(in: self) //record the last Location
                
                //if powerBar's power less equal 0
                if powerBar.power <= 0{
                    isDrawing = false
                    print("drew")
                    player1.draw(status: .end, point: nil)
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isDragging {
            isDragging = false
            let impulse = arrowNode.getImpulse()
            arrowNode.pushBall(player: player1)
            playerActionTmp.ActionType = .Move
            player2.DoAction(action: playerActionTmp, point: nil, impulse: impulse)
//            player2.pushBall(impulse: impulse)
            arrowNode.initVariable()
        }
        else if isDrawing{
            isDrawing = false
            print("drew")
            player1.draw(status: .end, point: nil)
            playerActionTmp.ActionType = .Draw(.end)
            player2.DoAction(action: playerActionTmp, point: nil, impulse: nil)
        }
    }
    
        override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
            print("Touches were Cancelled")
        }
    
    // Stoping the ballNode when speed less than 1
    override func update(_ currentTime: TimeInterval) {
        if let physicsBody = player1.ball.physicsBody {
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


