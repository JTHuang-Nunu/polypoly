//
//  Button.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/6/1.
//

import Foundation
import SpriteKit
class BaseButton: SKNode{
    public let OnClickBegin = Event<Void>()
    public let OnClickEnded = Event<Void>()
    override init() {
        super.init()
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        OnClickBegin.Invoke(())
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        OnClickEnded.Invoke(())
    }
    
}
