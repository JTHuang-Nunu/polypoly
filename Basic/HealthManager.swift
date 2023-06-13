//
//  HealthManager.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/6/7.
//

import Foundation

class HealthManager{
    public let OnDied = Event<Void>()

    private var MaxHealth: CGFloat = 5
    private var Health: CGFloat = 5 {
        didSet{
            if(Health <= 0) {
                IsDead()
            }
        }
    }
    init() {
        MaxHealth = 5
        Health = 5
    }
    convenience init(character: Character) {
        self.init()
    }
    convenience init (maxHP: CGFloat){
        self.init()
        MaxHealth = maxHP
        Health = maxHP
    }
    public func IsDead() {
        print("===health is zero===")
        OnDied.Invoke(())
    }
    
    public func initHP(maxHP: CGFloat){
        MaxHealth = maxHP
        Health = maxHP
    }
    
    
    internal func InjureHP(val: CGFloat){
        Health -= val
    }
    internal func SettingHP(val: CGFloat){
        Health = val
    }
    internal func RecoveryHP(val: CGFloat){
        Health += val
    }
}
