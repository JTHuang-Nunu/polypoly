//
//  BaseGameScene.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/6/14.
//

import Foundation
import SpriteKit

class BaseGameScene: SKScene{
    let gameManager = DeviceManager.shared.GameManager!
    var myCircle: SKShapeNode? = nil
    var myStartPoint = CGPoint()
    var othersPoint = CGPoint()
    override func didMove(to view: SKView) {
        let screenSize = UIScreen.main.bounds.size
               
       // 計算中心點的座標
       let centerX = screenSize.width / 2
       let centerY = screenSize.height / 2
       
       // 將場景的anchorPoint設置為中心點
       anchorPoint = CGPoint(x: 0.5, y: 0.5)
       position = CGPoint(x: -centerX, y: -centerY)
    }
    override func sceneDidLoad() {
        myStartPoint = CGPoint(x: -300, y: 0)
        othersPoint = CGPoint(x: 300, y: 0)
        createRedCircle()
        gameManager.OnCreatedCanvas += { canvas in
            self.addChild(canvas)
            //canvas.position = CGPoint(x: 0, y: 0)
            canvas.OnStartNewPoint += { _ in
                self.myCircle?.isHidden = false
            }
            canvas.OnFinishDrawPoint += { _ in
                self.myCircle?.isHidden = true
            }
            let screenSize = UIScreen.main.bounds.size
            canvas.position = CGPoint(x: -screenSize.width/2, y: -screenSize.height/2)
            
        }
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
        createBoundsWall()
    }
    func createBoundsWall(){
        let width = 700
        let height = 350
        let wall = Wall(size: CGSize(width: width, height: height), color: .systemBlue)
        wall.position = CGPoint(x: 0, y: 0)
        wall.zPosition = zAxis.Wall
        addChild(wall)
        

    }
    
    func PlacePlayerTo(players: [UUID: Character], point: CGPoint){
        for value in players.values{
            addChild(value.SKNode)
            value.SKNode.position = point
            value.OnCreateObstacle += addChild
            if point == myStartPoint{
                value.SKNode.addChild(myCircle!)
            }
        }
    }
    func createEnergyBar(manager: EnergyManager){
        let energyBar = EnergyBar(energyManager: manager)
        energyBar.position = CGPoint(x: 0, y: -130)
        addChild(energyBar)
    }
    func PlaceSkillButtons(skillButtons: [SkillSelectButton]){
        for i in 0..<skillButtons.count{
            let skill = skillButtons[i]
            skill.position = CGPoint(x:-380, y:100 - CGFloat(100 * i))
            skill.zPosition = zAxis.skillButton
            addChild(skill as SKNode)
            
        }
    }
    
    func createRedCircle(){
        myCircle = SKShapeNode(circleOfRadius: 200)
        myCircle!.fillColor = .clear
        myCircle!.strokeColor = .red
        myCircle!.alpha = 0.1
        myCircle!.lineWidth = 10
        myCircle!.zPosition = zAxis.Circle
        self.myCircle?.isHidden = true
        let action = SKAction.sequence([
            SKAction.fadeAlpha(to: 0.1, duration: 0.5),
            SKAction.fadeAlpha(to: 0, duration: 0.2)
        ])
        myCircle!.run(SKAction.repeatForever(action))
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        _update(currentTime)
    }

}
