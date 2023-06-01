//
//  TestScene.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/6/1.
//

import Foundation
import SpriteKit

class TestScene: SKScene{
    
    var ThisCharacter: CharacterModel? = nil
    var ThisUUID = UUID()
    override func sceneDidLoad() {
        CreatePlayer()
        CreateCanvas()
        let SimpleAction = PlayerAction(
            CharacterModelID: ThisUUID,
            ActionType: .Move,
            SkillID: 0,
            ActionTime: Date(),
            point: CGPoint(),
            impulse: CGVector(dx: 0, dy: 5))
        ThisCharacter?.DoAction(action: SimpleAction)
        
        
    }
    func CreatePlayer(){
        let character = CharacterFactory.shared.createCharacter(ID: ThisUUID)
        addChild(character.ball)
        ThisCharacter = character
    }
    func CreateCanvas(){
        let canvas = Canvas()
        addChild(canvas)
    }
    
    
}
