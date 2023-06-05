//
//  TestScene.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/6/3.
//

import Foundation
import SpriteKit

class TestScene: SKScene{
    let gameManager = GameManager.shared
    var ThisCharacter: Character? = nil
    var ThisCanvas: Canvas? = nil
    var ThisUUID = UUID()
    override func sceneDidLoad() {
        gameManager._dispatcher.RequestRoom()
        
        CreatePlayers()
        CreateCanvas()
        
    }
    func CreatePlayers(){
        ThisCharacter = gameManager.CreateCharacter(ID: ThisUUID)
        ThisCharacter!.position = CGPoint(x: 0, y: 0)
        addChild(ThisCharacter!.ball as SKNode)
    
        gameManager.SetOperateCharacter(ID: ThisUUID)
    }
    func CreateCanvas(){
        ThisCanvas = Canvas(pointerStartNode: ThisCharacter!.ball)
        ThisCanvas!.OnDrawPointer += GameManager.shared._inputManager.InputPointer
        addChild(ThisCanvas! as SKNode)
    }
}
