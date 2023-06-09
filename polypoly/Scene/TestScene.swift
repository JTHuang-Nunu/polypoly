//
//  TestScene.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/6/3.
//

import Foundation
import SpriteKit

class TestScene: SKScene{
    let gameManager = DeviceManager.shared.GameManager!
    let myPoint = CGPoint(x: 50, y: 0)
    let othersPoint = CGPoint(x: -50, y: 0)
    
    override func sceneDidLoad() {
        gameManager.OnCreatedCanvas += addChild
        gameManager.OnCreatedSelfPlayers += { players in
            self.PlacePlayerTo(players: players, point: self.myPoint)
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
        
        gameManager.OnWin += {
            print("win")
        }
        gameManager.OnLose += {
            print("lose")
        }
        
        // add win button
        let winButton = BaseButton()
        winButton.OnClickBegin += {
            self.gameManager.Win()
        }
        self.addChild(winButton)
        let shape = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 100, height: 100))
        shape.fillColor = UIColor.red
        winButton.addChild(shape)
        winButton.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        
        winButton.zPosition = zAxis.skillButton
        
        
        
        
        
        physicsWorld.gravity = CGVector(dx: 0.0, dy: 0.0)
        let interactionController = InteractionController()
        physicsWorld.contactDelegate = interactionController
        addChild(interactionController)
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
        energyBar.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 100)
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
    override func update(_ currentTime: TimeInterval) {
        _update(currentTime)
    }
}
