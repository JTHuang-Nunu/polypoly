//
//  Canvas.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/6/1.
//

import Foundation
import SpriteKit

class Canvas: SKShapeNode{

    let screenCenter: CGPoint = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)  //Locating my screen center for char and other object

//    var arrowNode: Arrow!
    var resetButton: SKShapeNode!
    var isDragging = false
    var isDrawing = false
    var startPoint: CGPoint = .zero
    
    var rect: SKShapeNode!
    var powerBar: PowerBar!
    var timer: Timer?
    
    //player variable
    var uuidDictionary = [Int: UUID]()
//    var uuidDictionary = [UUID: String]()
    var playerContainer = [Character]()
    var ThisPlayer: Character!
    var arrowNode = Arrow()
    init(thisPlayer this: Character) {
        self.ThisPlayer = this
        super.init()
        // Adjust the size of the canvas to match the screen dimensions
        let screenSize = UIScreen.main.bounds.size
        self.path = UIBezierPath(rect: CGRect(origin: CGPoint.zero, size: screenSize)).cgPath
        self.isUserInteractionEnabled = true
//        self.fillColor = .gray
        //add child
        self.addChild(arrowNode)
        
//        let circle = SKShapeNode(circleOfRadius: 30)
//              circle.fillColor = SKColor.red
//        circle.position = screenCenter
//        circle.zPosition = 100
//        self.addChild(circle)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch  = touches.first {
            let location = touch.location(in: self)
            isDragging = true
            arrowNode.updateArrow(start: location)
            
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if(isDragging){
                arrowNode.updateArrow(current: touch.location(in: self), objectNode: ThisPlayer.ball)
            }
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isDragging {
            
            isDragging = false
//            let impulse = arrowNode.getImpulse()
//            ThisPlayer.characterMove(force: impulse)
            arrowNode.pushBall(player: ThisPlayer)
            print("ThisPlayer",ThisPlayer.position)
            arrowNode.initVariable()
//            let impulse = arrowNode.getImpulse()
//            arrowNode.pushBall(player: player1)
//            arrowNode.initVariable()
        }
    }
    
    
}
