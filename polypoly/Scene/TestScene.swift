//
//  TestScene.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/6/1.
//

import Foundation
import SpriteKit

class TestScene: SKScene{
    
    var ThisCharacter: CharacterProtocol? = nil
    var ThisUUID = UUID()
    override func sceneDidLoad() {
        CreatePlayer()
        CreateCanvas()

        
        
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
