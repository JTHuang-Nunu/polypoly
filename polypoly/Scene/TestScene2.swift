
//
//  TestScene.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/6/3.
//

import Foundation
import SpriteKit

class TestScene2: SKScene{
    let gameManager = DeviceManager.shared.GameManager!
    
    let myPoint = CGPoint(x: 50, y: 0)
    let othersPoint = CGPoint(x: -50, y: 0)
//    let tmp: Character!
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
        createBoundsWall()
        
        GlobalPhysicsDelegate(in: self) // is using singleton
        
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
    func createBoundsWall(){
        let wall = Wall(size: UIScreen.main.bounds.size - CGSize(width: 140, height: 100), color: .clear)
        wall.position = CGPoint(0, 0)
//        wall.zPosition = zAxis.Base
        addChild(wall)
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





//import Foundation
//import SpriteKit
//
//class TestScene2: SKScene, SKPhysicsContactDelegate{
//    let gameManager = DeviceManager.shared.GameManager!
//    let myPoint = CGPoint(x: 50, y: 0)
//    let othersPoint = CGPoint(x: -50, y: 0)
//
//    var ThisCanvas: Canvas? = nil
//    var operateCharacter: Character? = nil
//    //-----------------------------------
//    override func sceneDidLoad() {
//        operateCharacter = gameManager.GetOperateCharacter()
//        self.CreatePlayers()
//        self.CreateCanvas()
//        let wall = Wall(size: UIScreen.main.bounds.size)
//        wall.position = CGPoint(x: 0, y: 0)
//        addChild(wall)
//        CreateSkills()
//        gameManager._skillManager?.SetSkill(skill: .Move)
//        physicsWorld.contactDelegate = self
//        physicsWorld.gravity = CGVector(dx: 0.0, dy: 0.0)
//
//    }
//    func CreatePlayers(){
//        let players = gameManager.GetCharacterMap()
//        for id in players.keys{
//            switch gameManager.IfSameDirectionWithOperateCharacter(id: id){
//            case true:
//                let character = players[id]
//                character?.ball.position = myPoint
//                addChild(character!.ball)
//                break
//            case false:
//                let character = players[id]
//                character?.ball.position = othersPoint
//                addChild(character!.ball)
//            default:
//                break
//            }
//        }
//
//    }
//    func CreateCanvas(){
//        ThisCanvas = Canvas(startNode: operateCharacter!.ball)
//        gameManager._inputManager.SetCanvas(canvas: ThisCanvas!)
//        addChild(ThisCanvas! as SKNode)
//    }
//    func CreateSkills(){
//        let skillButtons = gameManager._skillManager?.skillButtons
//        for i in 0..<skillButtons!.count{
//            let skill = skillButtons![i]
//            skill.position = CGPoint(x:self.frame.minX + 50 + CGFloat(100*i), y:self.frame.midY)
//            skill.zPosition = zAxis.skillButton
//            addChild(skill as SKNode)
//
//        }
//    }
//    override func update(_ currentTime: TimeInterval) {
//        _update(currentTime)
//    }
//}
