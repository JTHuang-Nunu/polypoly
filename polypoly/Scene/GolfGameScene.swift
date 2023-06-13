//
//  GolfGameScene.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/6/14.
//

import Foundation
import SpriteKit

class GolfGameScene: BaseGameScene{
    
    override func sceneDidLoad() {
        let backgroundImage = SKTexture(imageNamed: "galaxy3")
        
        let backgroundNode = SKSpriteNode(texture: backgroundImage, size: CGSize(width: 1000, height: 500))
        
        backgroundNode.zPosition = -1  // 設定在場景最下層
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
        }
        gameManager.OnLose += {
            print("golf lose")
        }
        super.sceneDidLoad()
        CreateBlackHole()
        
        
    
    }
    
    func CreateBlackHole(){
        let blackHole = BlackHole(position: CGPoint(x: 0, y: 0))
        blackHole.zPosition = zAxis.Ball
        addChild(blackHole)
        
        let blackHole2 = BlackHole(position: randomPoint())
        blackHole2.zPosition = zAxis.Ball
        addChild(blackHole2)
        
        let blackHole3 = BlackHole(position: randomPoint())
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
