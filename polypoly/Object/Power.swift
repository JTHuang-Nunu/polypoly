//
//  MPBar.swift
//  polypoly
//
//  Created by mac03 on 2023/5/9.
//

import UIKit
import SpriteKit

class Power: SKShapeNode {
//    private var width: CGFloat = 0
//    private var height: CGFloat = 0
//    private var powerBar: SKShapeNode? = nil
    private var maxValue: CGFloat = 0
    private var currValue: CGFloat = 0
    private var recoveryValueRate: CGFloat = 2
    private var powerBar: PowerBar? = nil
    init(CharacterPower value:CGFloat){
        self.maxValue = value  //set Character initial power value
        self.currValue = value
        super.init()
        self.setRecoveryPower()
    }
    internal func setPowerBar(bar: PowerBar) {
        powerBar = bar
    }
    internal func getCurrentValue() -> CGFloat {
        return currValue
    }
    internal func getMaxValue() -> CGFloat {
        return maxValue
    }
    internal func update(currentPower value: CGFloat){
        currValue = value
        if let powerBar = powerBar {
            powerBar.value = value
        }
    }
    internal func setRecoveryPower(){
        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true, block: { [weak self] _ in
                    guard let self = self else { return }
            if((currValue + recoveryValueRate) > maxValue){
                currValue = maxValue
            }
            self.update(currentPower: currValue + recoveryValueRate)
                })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
