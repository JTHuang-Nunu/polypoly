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
    
    var ThisCharacter: Character? = nil
    var ThisCanvas: Canvas? = nil
    var ThisUUID = UUID()
    override func sceneDidLoad() {
        deviceManager.EnterLobby()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.deviceManager._lobbyManager?.RequestRoom()
            
            self.deviceManager._lobbyManager?.OnCreateRoom += { _ in
                self.CreatePlayers()
                self.CreateCanvas()
            }
            
            
        }
        
        
        
        
    }
    func CreatePlayers(){
        ThisCharacter = self.deviceManager._gameManager?.CreateCharacter(ID: ThisUUID)
        ThisCharacter!.position = CGPoint(x: 0, y: 0)
        addChild(ThisCharacter!.ball as SKNode)
    
        self.deviceManager._gameManager?.SetOperateCharacter(ID: ThisUUID)
    }
    func CreateCanvas(){
        ThisCanvas = Canvas(pointerStartNode: ThisCharacter!.ball)
        ThisCanvas!.OnDrawPointer += { vector in
            self.deviceManager._gameManager?._inputManager.InputPointer(vector: vector)
        }
        addChild(ThisCanvas! as SKNode)
    }
}
