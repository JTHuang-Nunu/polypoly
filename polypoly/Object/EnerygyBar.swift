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
        
        FrameNode = SKShapeNode(rectOf: CGSize(width: 400, height: 20))
        BarNode = SKShapeNode(rectOf: CGSize(width: 400, height: 20))

        FrameNode.fillColor = UIColor.clear
        FrameNode.strokeColor = UIColor.black

        BarNode.fillColor = UIColor.green
        BarNode.strokeColor = UIColor.clear
        
        super.init()
        splitfield()
        self.addChild(FrameNode)
        self.addChild(BarNode)
    }
    
    private func splitfield(fieldCount: Int = 10){
        let fieldWidth = FrameNode.frame.width / CGFloat(fieldCount)
        let fieldHeight = FrameNode.frame.height
        for i in 1...fieldCount{
            let line = SKShapeNode(rectOf: CGSize(width: 1, height: fieldHeight))
            line.position.x = fieldWidth * CGFloat(i) - FrameNode.frame.width / 2
            line.zPosition = BarNode.zPosition + 1
            
            
            line.fillColor = UIColor.black
            line.strokeColor = UIColor.clear
            FrameNode.addChild(line)
        }
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
    }
}
