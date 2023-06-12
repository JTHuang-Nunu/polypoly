//
//  MPBar.swift
//  polypoly
//
//  Created by mac03 on 2023/5/9.
//

import UIKit
import SpriteKit

class EnergyManager: SKNode {
    public let OnEneryCost = Event<Float>()
    public let OnEnergyEmpty = Event<Void>()
    public let OnEneryFull = Event<Void>()
    
    public var Value: Float = 0.0
    public let MaxValue: Float
    public let MinValue: Float = 0.0
    
    public var EnableRecovery: Bool = true
    public var RecoveryRate: Float = 0.5
    
    
    private var previous_time: TimeInterval = 0.0
    public init(initValue: Float = 10, MaxValue: Float = 10) {
        self.Value = initValue
        self.MaxValue = MaxValue
        super.init()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func Cost(costValue: Float) {
        self.Value -= costValue
        if self.Value < self.MinValue {
            self.Value = self.MinValue
            self.OnEnergyEmpty.Invoke(())
        }
        self.OnEneryCost.Invoke(self.Value)
    }
    override func NodeUpdate(_ currentTime: TimeInterval) {
        if self.previous_time == 0.0 {
            self.previous_time = currentTime
        }
        let delta = currentTime - self.previous_time
        self.previous_time = currentTime
        
        if self.EnableRecovery {
            self.Value += self.RecoveryRate * Float(delta)
            if self.Value > self.MaxValue {
                self.Value = self.MaxValue
                OnEneryFull.Invoke(())
            }
        }
    
    }
    public var Percent: CGFloat {
        get {
            return CGFloat(self.Value) / CGFloat(self.MaxValue)
        }
    }
}
