
//
//  TestScene.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/6/3.
//

import Foundation
import SpriteKit

class TestScene2: SKScene, SKPhysicsContactDelegate{
    let gameManager = DeviceManager.shared.GameManager!
    
    let myPoint = CGPoint(x: 50, y: 0)
    let othersPoint = CGPoint(x: -50, y: 0)
    
    var operateCharacter: Character? = nil
    //-----------------------------------
    override func sceneDidLoad() {
        gameManager.OnCreatedCanvas += addChild
        gameManager.OnCreatedPlayers += CreatePlayers
        gameManager.OnCreatedSkillButtons += CreateSkills
        gameManager.CreateSceneObjects()
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0.0, dy: 0.0)
        
//        operateCharacter?.OnDrawObstacle += createOBO
        operateCharacter?.OnCreateObstacle += addChild
    }
//    override func didMove(to view: SKView){
//        operateCharacter?.OnDrawObstacle += createOBO
//    }
//    func createOBO(node: SKNode) {
//        self.addChild(node)
//
//
//        let borderNode = SKShapeNode()
//        let borderSize = CGSize(width: 200, height: 100)
////        let borderRect = CGRect(origin: CGPoint(x: -borderSize.width / 2, y: -borderSize.height / 2), size: borderSize)
//        let borderRect = CGRect(origin: CGPoint(x: 0, y: 0), size: borderSize)
//        borderNode.path = UIBezierPath(rect: borderRect).cgPath
//        borderNode.lineWidth = 2
//        borderNode.strokeColor = UIColor.yellow
//        addChild(borderNode)
//    }
    func CreatePlayers(players: [UUID: Character]){
        for id in players.keys{
            switch gameManager.IfSameDirectionWithOperateCharacter(id: id){
            case true:
                let character = players[id]
                character?.ball.position = myPoint
                addChild(character!.ball)
                
                operateCharacter = character
                break
            case false:
                let character = players[id]
                character?.ball.position = othersPoint
                addChild(character!.ball)
            default:
                break
            }
        }
    }
    func CreateSkills(skillButtons: [SkillSelectButton]){
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
