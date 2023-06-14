
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
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                self.view?.presentScene(WinScene)
            }
        }
        gameManager.OnLose += {
            print("soccer lose")
            let LoseScene = LoseScene(size: self.size)
            LoseScene.scaleMode = .aspectFill
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                self.view?.presentScene(LoseScene)
            }
        }
        
        addChild(otherGoalLine)
    
    }
    func createBall(){
        let ball = Ball(len: 80)
        ball.texture = SKTexture(imageNamed: SoccerName)
        ball.name = SoccerName
        
//        ball.size = CGSize(
        ball.physicsBody?.mass = PhysicsMass.Ball - 1.0
        
        ball.position = CGPoint(x: 0, y: 0)
//        ball.position = CGPoint(x: -399, y: -50)
//        ball.zPosition = 100
        addChild(ball)
    
    }

}
