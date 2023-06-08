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
    
    var ThisCanvas: Canvas? = nil
    //-----------------------------------
    override func sceneDidLoad() {
        self.CreatePlayers()
        self.CreateCanvas()
        let wall = Wall(size: UIScreen.main.bounds.size)
        wall.position = CGPoint(x: 0, y: 0)
        addChild(wall)
        CreateSkills()
        gameManager._skillManager?.SetSkill(skill: .Move)
    }
    func CreatePlayers(){
        let players = gameManager.GetCharacterMap()
        for id in players.keys{
            switch gameManager.IfSameDirectionWithOperateCharacter(id: id){
            case true:
                let character = players[id]
                character?.ball.position = myPoint
                addChild(character!.ball)
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
    func CreateCanvas(){
        ThisCanvas = Canvas(pointerStartNode: gameManager.GetOperateCharacter()!.ball)
        gameManager._inputManager.SetCanvas(canvas: ThisCanvas!)
        addChild(ThisCanvas! as SKNode)
    }
    func CreateSkills(){
        let skillButtons = gameManager._skillManager?.skillButtons
        for skill in skillButtons!{
            skill.position = CGPoint(x:self.frame.minX + 50, y:self.frame.midY)
            skill.zPosition = zAxis.skillButton
            addChild(skill as SKNode)
        }
    }
}
