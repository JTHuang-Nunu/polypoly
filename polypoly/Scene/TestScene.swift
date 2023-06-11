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
    
    var operateCharacter: Character? = nil
    //-----------------------------------
    override func sceneDidLoad() {
        gameManager.OnCreatedCanvas += addChild
        gameManager.OnCreatedPlayers += CreatePlayers
        gameManager.OnCreatedSkillButtons += CreateSkills
        gameManager.CreateSceneObjects()
        
    }
    func CreatePlayers(players: [UUID: Character]){
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
    func CreateSkills(skillButtons: [SkillSelectButton]){
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
