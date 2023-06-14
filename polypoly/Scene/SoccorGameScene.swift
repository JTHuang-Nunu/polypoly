
//
//  TestScene.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/6/3.
//

import Foundation
import SpriteKit

class SoccorGameScene: BaseGameScene{
    private var backgroundNode: SKSpriteNode!
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        createBall()
        createGoalLines()
        createStartLabel()
        let backgroundImage = SKTexture(imageNamed: "soccer_background2")
//        let tmp = SKT
              
          // 建立背景節點
        backgroundNode = SKSpriteNode(texture: backgroundImage, size: CGSize(width: 900, height: 400))
          backgroundNode.zPosition = -1  // 設定在場景最下層
          addChild(backgroundNode)
    }
    func createGoalLines(){
        let myGoalLine = GoalLine(color: .red)
        myGoalLine.position = CGPoint(x: -350, y: 0)
        myGoalLine.zPosition = zAxis.GoalLine
        addChild(myGoalLine)
        
        let otherGoalLine = GoalLine(color: .yellow)
        otherGoalLine.position = CGPoint(x: 350, y: 0)
        otherGoalLine.zPosition = zAxis.GoalLine
        otherGoalLine.OnGoal += {
            self.gameManager.Win()
        }
        
        gameManager.OnWin += {
            print("soccer win")
            let WinScene = WinScene(size: self.size)
            WinScene.scaleMode = .aspectFill
            self.view?.presentScene(WinScene)
        }
        gameManager.OnLose += {
            print("soccer lose")
            let LoseScene = LoseScene(size: self.size)
            LoseScene.scaleMode = .aspectFill
            self.view?.presentScene(LoseScene)
        }
        
        addChild(otherGoalLine)
    
    }
    func createBall(){
        let ball = Ball()
        ball.texture = SKTexture(imageNamed: SoccerName)
        ball.name = SoccerName
        
        ball.position = CGPoint(x: 0, y: 0)
//        ball.position = CGPoint(x: -399, y: -50)
//        ball.zPosition = 100
        addChild(ball)
    
    }
    func createStartLabel(){
        let startLabel = SKLabelNode(text: "Ready Go！")
        startLabel.name = "start"
        startLabel.fontName = "HelveticaNeue-Bold"
        startLabel.fontColor = .white
        startLabel.fontSize = 100
        startLabel.horizontalAlignmentMode = .center
        startLabel.verticalAlignmentMode = .center
        startLabel.zPosition = zAxis.Base
//        let shapeNode = SKShapeNode(rect: CGRect(center: .zero, width: 380, height: 100), cornerRadius: 30)
//        shapeNode.name = "shape"
//        shapeNode.fillColor = SKColor.white
        self.addChild(startLabel)
        let fadeInAction = SKAction.fadeIn(withDuration: 0.4)
        let fadeOutAction = SKAction.fadeOut(withDuration: 0.4)
        let fade = SKAction.sequence([fadeOutAction, fadeInAction])
        let repeatPulse = SKAction.repeat(fade, count: 3)
        
        let scale = SKAction.scale(to: 20, duration: 1)
//        let waitAction = SKAction.wait(forDuration: 3.0)
        let removeAction = SKAction.removeFromParent()
       let sequenceAction = SKAction.sequence([repeatPulse, scale, removeAction])
            
        startLabel.run(sequenceAction)
    }
}
