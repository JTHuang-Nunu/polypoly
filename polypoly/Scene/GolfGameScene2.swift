//
//  GolfGameScene2.swift
//  polypoly
//
//  Created by mac03 on 2023/6/14.
//

import Foundation
import SpriteKit

class GolfGameScene2: BaseGameScene{
    
    override func sceneDidLoad() {
//        let backgroundImage = SKTexture(imageNamed: "galaxy3")
//        let backgroundNode = SKSpriteNode(texture: backgroundImage, size: CGSize(width: 1000, height: 500))
        let backgroundNode = SKShapeNode(rect: CGRect(center: CGPoint(0, 0), size: CGSize(width: 1000, height: 500)))
        backgroundNode.fillColor = UIColor(red: 100, green: 236, blue: 236, alpha: 0.3)
//        backgroundNode.fillColor = .systemCyan
        backgroundNode.zPosition = 0  // 設定在場景最下層
        addChild(backgroundNode)
        gameManager.OnCreatedOtherPlayers += {map in
            for (_, cha) in map{
                cha.OnPlayerDied += {_ in
                    self.gameManager.Win()
                }
            }
        }
        gameManager.OnWin += {
            print("golf win")
            let WinScene = WinScene(size: self.size)
            WinScene.scaleMode = .aspectFill
            // delay 2 second and tp
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                self.view?.presentScene(WinScene)
            }
        }
        gameManager.OnLose += {
            print("golf lose")
            let LoseScene = LoseScene(size: self.size)
            LoseScene.scaleMode = .aspectFill
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                self.view?.presentScene(LoseScene)
            }
        }
        super.sceneDidLoad()
        CreateBlackHole()
        createStartLabel()
        
    
    }
    
    func CreateBlackHole(){
        let offsetX = 200.0
        let offsetY = 100.0
        let blackHole1 = BlackHole(position: CGPoint(x: offsetX, y: offsetY))
        blackHole1.zPosition = zAxis.Ball
        addChild(blackHole1)
        let blackHole4 = BlackHole(position: CGPoint(x: offsetX, y: -offsetY))
        blackHole4.zPosition = zAxis.Ball
        addChild(blackHole4)
        
        let blackHole2 = BlackHole(position: CGPoint(x: -offsetX, y: -offsetY))
        blackHole2.zPosition = zAxis.Ball
        addChild(blackHole2)
        let blackHole3 = BlackHole(position: CGPoint(x: -offsetX, y: offsetY))
        blackHole3.zPosition = zAxis.Ball
        addChild(blackHole3)

    }
    
    func randomPoint() -> CGPoint{
        let offset:CGFloat = 30
        let minX = -UIScreen.main.bounds.width / 2 + offset
        let maxX = UIScreen.main.bounds.width / 2 - offset
        let minY = -UIScreen.main.bounds.height / 2 + offset
        let maxY = UIScreen.main.bounds.height / 2 - offset

        let randomX = CGFloat(arc4random_uniform(UInt32(maxX - minX))) + minX
        let randomY = CGFloat(arc4random_uniform(UInt32(maxY - minY))) + minY
        
        return CGPoint(randomX, randomY)
    }
}
