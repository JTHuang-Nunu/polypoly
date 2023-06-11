//
//  EnerygyBar.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/6/11.
//

import Foundation
import SpriteKit

class EnergyBar: SKNode{
    private let energyManager: EnergyManager
    private let FrameNode: SKShapeNode
    private let BarNode: SKShapeNode
    
    init(energyManager: EnergyManager){
        self.energyManager = energyManager
        
        FrameNode = SKShapeNode(rectOf: CGSize(width: 200, height: 20))
        BarNode = SKShapeNode(rectOf: CGSize(width: 200, height: 20))

        FrameNode.fillColor = UIColor.clear
        FrameNode.strokeColor = UIColor.black

        BarNode.fillColor = UIColor.green
        BarNode.strokeColor = UIColor.clear
        super.init()
        self.addChild(FrameNode)
        self.addChild(BarNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func SetBarPercent(percent: CGFloat) {
        BarNode.xScale = percent
        BarNode.position.x = -FrameNode.frame.width * (1 - percent) / 2
    }
    
    
    override func NodeUpdate(_ currentTime: TimeInterval) {
        SetBarPercent(percent: energyManager.Percent)
//        print(energyManager.Percent)
    }
}
