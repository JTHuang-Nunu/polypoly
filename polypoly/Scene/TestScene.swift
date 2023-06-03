//
//  TestScene.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/6/3.
//

import Foundation
import SpriteKit

class TestScene: SKScene{
    
    var ThisCharacter: Character? = nil
    var ThisCanvas: Canvas? = nil
    var ThisUUID = UUID()
    override func sceneDidLoad() {
        CreatePlayer()
        CreateCanvas()
    
        ThisCanvas!.OnDrawPointer += InputManager.shared.InputPointer
        InputManager.shared.OnDoPlayerAction += ThisCharacter!.DoAction
        
    }
    func CreatePlayer(){
        let character = CharacterFactory.shared.createCharacter(ID: ThisUUID)
        addChild(character.ball)
        ThisCharacter = character
    }
    func CreateCanvas(){
        ThisCanvas = Canvas(pointerStartNode: ThisCharacter!.ball)
        addChild(ThisCanvas! as SKNode)
    }
}
