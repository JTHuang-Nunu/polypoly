//
//  PowerBar.swift
//  polypoly
//
//  Created by mac03 on 2023/6/4.
//

import Foundation
import SpriteKit

class PowerBar: SKShapeNode {
    private var width: CGFloat = 300
    private var height: CGFloat = 30
    private var currBarNode: SKShapeNode!
    var power: Power?
    var value: CGFloat {
        didSet{
            let newWidth = self.width * (value / power!.getMaxValue())
            self.currBarNode.path =  CGPath(roundedRect: CGRect(x: -self.width/2, y: -self.height/2, width: newWidth, height: self.height), cornerWidth: self.height/2, cornerHeight: self.height/2, transform: nil)
        }
    }
    init(position: CGPoint, power: Power) {
        self.power = power
        self.value = power.getCurrentValue()
        super.init()
        createPowerBar()
    }
    init(position: CGPoint, power: Power, width: CGFloat, height: CGFloat) {
        self.power = power
        self.value = power.getCurrentValue()
        self.width = width
        self.height = height
        super.init()
        createPowerBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func createPowerBar(){
        // 畫出能量條的背景
        let bgNode = SKShapeNode(rectOf: CGSize(width: self.width, height: self.height), cornerRadius: self.height/2)

        bgNode.fillColor = .gray
        bgNode.lineWidth = 0
//        bgNode.position = position
        self.addChild(bgNode)
        
        // 畫出能量條
        let powerPath = CGPath(roundedRect: CGRect(x: -self.width/2, y: -self.height/2, width: self.width, height: self.height), cornerWidth: self.height/2, cornerHeight: self.height/2, transform: nil)
        currBarNode = SKShapeNode(path: powerPath)
        currBarNode.fillColor = .yellow
        currBarNode.strokeColor = .white
        currBarNode.lineWidth = 0
//        powerNode.position = position
        self.addChild(currBarNode)
    }
    
}
