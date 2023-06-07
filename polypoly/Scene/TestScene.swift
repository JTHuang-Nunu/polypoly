//
//  TestScene.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/6/3.
//

import Foundation
import SpriteKit

class TestScene: SKScene{
    let deviceManager = DeviceManager.shared
    let gameManager = DeviceManager.shared.GameManager!
    
    var ThisCharacter: Character? = nil
    var ThisCanvas: Canvas? = nil
    var ThisUUID = UUID()
    //-----------------------------------
    override func sceneDidLoad() {
        self.CreatePlayers()
        self.CreateCanvas()
    }
    func CreatePlayers(){
        ThisCharacter = gameManager.CreateCharacter(ID: ThisUUID)
        ThisCharacter!.position = CGPoint(x: 0, y: 0)
        addChild(ThisCharacter!.ball as SKNode)
    
        gameManager.SetOperateCharacter(ID: ThisUUID)
    }
    func CreateCanvas(){
        ThisCanvas = Canvas(pointerStartNode: ThisCharacter!.ball)
        ThisCanvas!.OnDrawPointer += { vector in
            self.gameManager._inputManager.InputPointer(vector: vector)
        }
        addChild(ThisCanvas! as SKNode)
    }
}
