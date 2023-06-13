
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
    
    let myStartPoint = CGPoint(x: 50, y: 0)
    let othersPoint = CGPoint(x: -50, y: 0)
    
    override func sceneDidLoad() {
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
    }
    func createBoundsWall(){
        let wall = Wall(size: UIScreen.main.bounds.size - CGSize(width: 140, height: 100), color: .clear)
        wall.position = CGPoint(0, 0)
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
