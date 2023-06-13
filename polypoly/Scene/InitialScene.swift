//
//  initialScene.swift
//  polypoly
//
//  Created by mac03 on 2023/4/30.
//

import UIKit
import SpriteKit

class InitialScene: SKScene {
    let earth = SKSpriteNode(imageNamed: "earth")
    var button = BaseButton()
    override func didMove(to view: SKView){
        DeviceManager.shared.Initialize()
        createScene()
        //Start Label
        createStartLabel()
//        let button = BaseButton()
        button.position = CGPoint(x:self.frame.maxX - 50, y:self.frame.midY)
        button.OnClickBegin += {
            DeviceManager.shared.RequestRoom()
        }
//        let delay = SKAction.wait(forDuration: 2.0) // Adjust the delay duration as needed
//            let clickAction = SKAction.run {
//                button.OnClickBegin.Invoke(())
//            }
 
        let label = SKLabelNode(text: "test")
        label.fontName = "HelveticaNeue-Bold"
        label.fontSize = 50
        button.addChild(label)
        self.addChild(button)
        DeviceManager.shared.OnEnterGame += {
            self.gotoTestScene()
        }
        
    }
//    override func update(_ currentTime: TimeInterval) {
//        button.OnClickBegin.Invoke(())
//    }
    
    func createScene(){
        let bgd = SKSpriteNode(color: UIColor.black, size: self.size)
        bgd.size.width = self.size.width
        bgd.size.height = self.size.height
        bgd.position = CGPoint(x:self.frame.midX, y:self.frame.midY)
        bgd.zPosition = -10
        self.addChild(bgd)
    }
    
    func createStartLabel(){
        let startLabel = SKLabelNode(text: "S T A R T")
        startLabel.name = "start"
        startLabel.position = CGPoint(x:self.frame.midX, y:self.frame.midY)
        startLabel.fontName = "HelveticaNeue-Bold"
        startLabel.fontSize = 50
        self.addChild(startLabel)
        doBlinkForever(name: "start")
    }
    
    func doBlinkForever(name: String){
        let labelNode = self.childNode(withName: name)
        let fadeIn = SKAction.fadeIn(withDuration: 0.4)
        let fadeOut = SKAction.fadeOut(withDuration: 0.4)
        let wait = SKAction.wait(forDuration: 0.3)
        let blink = SKAction.sequence([wait,fadeOut, fadeIn])
        let blinkForever = SKAction.repeatForever(blink)
        labelNode?.run(blinkForever)
    }
    func gotoTestScene(){
        let testScene = SoccorGameScene(fileNamed: "TestScene copy")!
        testScene.scaleMode = .aspectFill
        self.view?.presentScene(testScene)
    }

}
