//
//  Canvas.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/6/1.
//

import Foundation
import SpriteKit

class Canvas: SKShapeNode{
    var line: DrawLine? = nil
    
    override init() {
        super.init()
        
        // Adjust the size of the canvas to match the screen dimensions
        let screenSize = UIScreen.main.bounds.size
        self.path = UIBezierPath(rect: CGRect(origin: CGPoint.zero, size: screenSize)).cgPath
        self.isUserInteractionEnabled = true
        self.position = CGPoint(x: -screenSize.width/2, y: -screenSize.height/2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        line = DrawLine(lineWidth: 5)
        line?.SetStartPoint(startPoint: touches.first!.location(in: scene!))
        scene?.addChild(line!)
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        line?.UpdateLine(newPoint: touches.first!.location(in: scene!))
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        line?.removeFromParent()
    }
    
    
}
