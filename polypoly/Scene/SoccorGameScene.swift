
//
//  TestScene.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/6/3.
//

import Foundation
import SpriteKit

class SoccorGameScene: SKScene{
    let gameManager = DeviceManager.shared.GameManager!
    
    var myStartPoint = CGPoint()
    var othersPoint = CGPoint()
    
    override func sceneDidLoad() {
        myStartPoint = CGPoint(x: frame.midX + 50, y: frame.midY)
        othersPoint = CGPoint(x: frame.midX - 50, y: frame.midY)
        gameManager.OnCreatedCanvas += addChild
        gameManager.OnCreatedSelfPlayers += { players in
            self.PlacePlayerTo(players: players, point: self.myStartPoint)
        }
        gameManager.OnCreatedOtherPlayers += { players in
            self.PlacePlayerTo(players: players, point: self.othersPoint)
        }
        gameManager.OnCreatedEneryManager += { manager in
            self.addChild(manager)
            self.createEnergyBar(manager: manager)
        }
        gameManager.OnCreatedSkillButtons += PlaceSkillButtons
        gameManager.CreateSceneObjects()
        

        GlobalPhysicsDelegate(in: self)
        
        let interactionController = InteractionController()
        physicsWorld.contactDelegate = interactionController
        addChild(interactionController)
        
        createBall()
        createBoundsWall()
        createGoalLines()
    }
    func createGoalLines(){
        let myGoalLine = GoalLine()
        myGoalLine.position = CGPoint(x: frame.midX - 399, y: frame.midY - 50)
        myGoalLine.zPosition = zAxis.GoalLine
        addChild(myGoalLine)
        
        let otherGoalLine = GoalLine()
        otherGoalLine.position = CGPoint(x: frame.midX + 349, y: frame.midY - 50)
        otherGoalLine.zPosition = zAxis.GoalLine
        addChild(otherGoalLine)
    
    }
    func createBoundsWall(){
        let width = 700
        let height = 350
        let wall = Wall(size: CGSize(width: width, height: height), color: .systemOrange)
        wall.position = CGPoint(x: frame.midX, y: frame.midY)
        wall.zPosition = zAxis.Wall
        addChild(wall)
    }
    func createBall(){
        let ball = Ball()
        ball.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        ball.zPosition = zAxis.Ball
        addChild(ball)
    
    }
    
    func PlacePlayerTo(players: [UUID: Character], point: CGPoint){
        for value in players.values{
            addChild(value.SKNode)
            value.SKNode.position = point
            value.OnCreateObstacle += addChild
        }
    }
    func createEnergyBar(manager: EnergyManager){
        let energyBar = EnergyBar(energyManager: manager)
        energyBar.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 130)
        addChild(energyBar)
    }
    func PlaceSkillButtons(skillButtons: [SkillSelectButton]){
        for i in 0..<skillButtons.count{
            let skill = skillButtons[i]
            skill.position = CGPoint(x:self.frame.minX + 50 + CGFloat(100*i), y:self.frame.midY)
            skill.zPosition = zAxis.skillButton
            addChild(skill as SKNode)
            
        }
    }
    func CreateObstaclObject(node: SKNode){
        
    }
    override func update(_ currentTime: TimeInterval) {
        _update(currentTime)
    }
}
