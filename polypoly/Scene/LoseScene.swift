//
//  LoseScene.swift
//  polypoly
//
//  Created by mac03 on 2023/6/14.
//

import Foundation
import SpriteKit

class LoseScene: BaseGameScene{
    override func sceneDidLoad() {
        guard let animation = AnimationFactory.shared.create(type: .lose, position: CGPoint(0, 0), node: nil).play() else {return}
        animation.position = CGPoint(0, 0)
        addChild(animation)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.removeAllChildren()
        
        let MenuScene = MenuScene(size: self.size)
        MenuScene.scaleMode = .aspectFill
        self.view?.presentScene(MenuScene)
    }
}
