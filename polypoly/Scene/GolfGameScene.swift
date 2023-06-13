//
//  GolfGameScene.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/6/14.
//

import Foundation

class GolfGameScene: BaseGameScene{
    
    override func sceneDidLoad() {
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
    }
}
