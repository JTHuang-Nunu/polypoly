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
    override func didMove(to view: SKView){
        createScene()
        //Start Label
        createStartLabel()
        
    }
    
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

}
