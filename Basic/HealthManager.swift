//
//  HealthManager.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/6/7.
//

import Foundation
enum HealthType {
    case Recovery
    case Injure
    case Setting
}

class HealthManager{
    public let OnDied = Event<Void>()

    private var MaxHealth: CGFloat = 5
    private var Health: CGFloat = 5 {
        didSet{
            if(Health == 0) {
                IsDead()
            }
        }
    }
    init(){
        
    }
    init (maxHP: CGFloat){
        MaxHealth = maxHP
        Health = maxHP
    }
    public func IsDead() {
        print("===Lost game===")
//        OnDied.Invoke(<#Void#>)
    }
    
    public func initHP(maxHP: CGFloat){
        MaxHealth = maxHP
        Health = maxHP
    }
    public func update(val: CGFloat, type: HealthType){
        switch type{
        case .Recovery:
            Health += val
        case .Injure:
            Health -= val
        case .Setting:
            Health = val
        }
    }
    
    
}
