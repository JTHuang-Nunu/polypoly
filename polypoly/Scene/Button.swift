//
//  Button.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/6/1.
//

import Foundation
import SpriteKit
class Button: SKShapeNode{
    //do a square button with blue color fill in
    override init() {
        super.init()
        self.path = UIBezierPath(rect: CGRect(origin: CGPoint.zero, size: CGSize(width: 50, height: 50))).cgPath
        self.isUserInteractionEnabled = true
        self.fillColor = .blue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("click button")
    }
    
}
