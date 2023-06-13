//
//  HomeScene.swift
//  polypoly
//
//  Created by mac03 on 2023/6/12.
//

import Foundation
import SpriteKit

class HomeScene: SKScene {
    var isStarted: Bool = false
    let duration = 3.5
    let bg = BackgroundAndFootball()
    override func didMove(to view: SKView) {
        DeviceManager.shared.Initialize()
        createStartLabel()
        addChild(bg)
    }
    func start(){
        let actionSequence = SKAction.sequence([
            SKAction.run{ [self] in
                bg.play()
                backgroundFromBlackToWhite()
            },
        
            SKAction.wait(forDuration: duration),

        ])
        self.run(actionSequence, completion: {
            let T = SKTransition.fade(withDuration: 0.5)
            self.view?.presentScene(InputNameScene(size: self.size), transition: T)
        })
    }
    func backgroundFromBlackToWhite(){
        let node = SKSpriteNode(color: .black, size: ScreenSize)
        node.position = ScreenCenter
        self.addChild(node)

        let colorizeAction = SKAction.colorize(with: .white, colorBlendFactor: 1.0, duration: 3)
        node.run(colorizeAction)
    }
    func createStartLabel(){
        let mainNode = SKNode()
        let startLabel = SKLabelNode(text: "- S T A R T -")
        startLabel.name = "start"
        startLabel.fontName = "HelveticaNeue-Bold"
        startLabel.fontColor = .black
        startLabel.fontSize = 50
        startLabel.horizontalAlignmentMode = .center
        startLabel.verticalAlignmentMode = .center
        let shapeNode = SKShapeNode(rect: CGRect(center: .zero, width: 380, height: 100), cornerRadius: 30)
        shapeNode.name = "shape"
        shapeNode.fillColor = SKColor.white
        
        
        mainNode.name = "button"
        mainNode.position = CGPoint(x:self.frame.midX, y:self.frame.midY)
        mainNode.addChild(shapeNode.shadow())
        mainNode.addChild(shapeNode)
        mainNode.addChild(startLabel)
        mainNode.zPosition = 10
        
        self.addChild(mainNode)
        doBlinkForever(node: startLabel)
    }
    
    func doBlinkForever(node: SKLabelNode){
        let fadeIn = SKAction.fadeIn(withDuration: 0.6)
        let fadeOut = SKAction.fadeOut(withDuration: 0.6)
        let wait = SKAction.wait(forDuration: 0.3)
        let blink = SKAction.sequence([wait,fadeOut, fadeIn])
        let blinkForever = SKAction.repeatForever(blink)
        node.run(blinkForever, withKey: "   ")
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let touchLocation = touch.location(in: self)
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let touchLocation = touch.location(in: self)
            if !isStarted{
                // 檢查是否觸碰到指定的節點
                if let node = self.nodes(at: touchLocation).first(where: { $0.name == "button" }) {
                    if let shapeNode = node.childNode(withName: "shape") as? SKShapeNode {
                        // 將節點的顏色設定為黑色
                        shapeNode.fillColor = UIColor(red: 133, green: 133, blue: 133, alpha: 0.5)
                    }
                } else {
                    // 若沒有觸碰到節點，將所有節點的顏色還原為白色
                    let node = self.childNode(withName: "button")
                    if let shapeNode = node!.childNode(withName: "shape") as? SKShapeNode {
                        shapeNode.fillColor = SKColor.white
                    }
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let touchLocation = touch.location(in: self)
            
            // 檢查是否觸碰到指定的節點
            if let node = self.nodes(at: touchLocation).first(where: { $0.name == "button" }) {
                node.removeAction(forKey: "blinkAction")
                isStarted = true
                node.run(SKAction.fadeOut(withDuration: 0.5),completion: {[self] in
                    node.run(SKAction.removeFromParent())
                    start()
                })
                
            }
        }
    }
    
}

class BackgroundAndFootball: SKNode {
    let folderName = StartBackgroundFolder
    var node = SKSpriteNode()
    var textures: [SKTexture]?
    var background: SKSpriteNode?
    override init(){
        let atlas = SKTextureAtlas(named: folderName)
        textures = (0...atlas.textureNames.count-2).map { atlas.textureNamed(String(format: "%d", $0))}
        background = SKSpriteNode(imageNamed: "roadbackground")
        super.init()
        runBackground()
    }
    public func play(){
        guard let textures = textures else {return}
        node.texture = textures[0]

        let animation = SKAction.animate(with: textures, timePerFrame: 0.7)
        node.run(SKAction.sequence([
            animation,
            SKAction.run{ [self] in //stop on last frame
                node.texture = textures.last
            }
        ]))
        
        node.position = ScreenCenter
        
        node.zPosition = 1
        addChild(node)
    }
    public func runBackground() {
        guard let background = background else {return}
        background.position = ScreenCenter
        background.zPosition = 0

        node.size = background.fitScreen()!
        addChild(background)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

