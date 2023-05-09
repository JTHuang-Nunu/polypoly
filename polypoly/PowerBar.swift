//
//  MPBar.swift
//  polypoly
//
//  Created by mac03 on 2023/5/9.
//

import UIKit
import SpriteKit

class PowerBar: SKShapeNode {
    private var width: CGFloat = 0
    private var height: CGFloat = 0
    private var powerBar: SKShapeNode?
    internal var maxPower: CGFloat = 0
    
    var power: CGFloat = 0{
        didSet {
            if power > maxPower {
                power = maxPower
            }
            //if power value is changed, updating powerBar width
            if power > 0 {
                let newWidth = self.width * (power/maxPower)
                self.powerBar?.path =  CGPath(roundedRect: CGRect(x: -self.width/2, y: -self.height/2, width: newWidth, height: self.height), cornerWidth: self.height/2, cornerHeight: self.height/2, transform: nil)
//                print("newWidth",newWidth)
            }else if power <= 0{
                power = 0
                self.powerBar?.path =  CGPath(roundedRect: CGRect(x: -self.width/2, y: -self.height/2, width: 0, height: self.height), cornerWidth: self.height/2, cornerHeight: self.height/2, transform: nil)
            }
        }
    }
    
    init(position: CGPoint, width: CGFloat, height: CGFloat, power: CGFloat) {
        super.init()
        self.width = width
        self.height = height
        self.power = power
        self.maxPower = power
//        self.position = position
        // 畫出能量條的背景
        let bgNode = SKShapeNode(rectOf: CGSize(width: self.width, height: self.height), cornerRadius: self.height/2)

        bgNode.fillColor = .gray
        bgNode.lineWidth = 0
        bgNode.position = position
        addChild(bgNode)
        
        // 畫出能量條
        let powerPath = CGPath(roundedRect: CGRect(x: -self.width/2, y: -self.height/2, width: self.width, height: self.height), cornerWidth: self.height/2, cornerHeight: self.height/2, transform: nil)
        let powerNode = SKShapeNode(path: powerPath)
        powerNode.fillColor = .yellow
        powerNode.strokeColor = .white
        powerNode.lineWidth = 0
        powerNode.position = position
        addChild(powerNode)
        self.powerBar = powerNode
    }
    
    internal func recoveryPower(){
        self.power += maxPower/250
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
