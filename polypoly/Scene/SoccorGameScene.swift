
//
//  TestScene.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/6/3.
//

import Foundation
import SpriteKit

class SoccorGameScene: BaseGameScene{
    override func sceneDidLoad() {
        super.sceneDidLoad()
        createBall()
        createGoalLines()
    }
    func createGoalLines(){
        let myGoalLine = GoalLine()
        myGoalLine.position = CGPoint(x: -399, y: -50)
        myGoalLine.zPosition = zAxis.GoalLine
        addChild(myGoalLine)
        
        let otherGoalLine = GoalLine()
        otherGoalLine.position = CGPoint(x: 349, y: -50)
        otherGoalLine.zPosition = zAxis.GoalLine
        otherGoalLine.OnGoal += {
            self.gameManager.Win()
        }
        addChild(otherGoalLine)
    
    }
    func createBall(){
        let ball = Ball()
        ball.name = "soccorBall"
        ball.position = CGPoint(x: 0, y: 0)
        ball.zPosition = zAxis.Ball
        addChild(ball)
    
    }
}
