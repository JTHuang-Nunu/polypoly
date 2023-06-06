//
//  HealthManager.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/6/7.
//

import Foundation


class HealthManager{
    public let OnDied = Event<Void>()
    
    var MaxHealth: Int = 100
    var Health: Int = 100
    init(){
        
    }
    
    public var IsDead: Bool{
        get{
            Health == 0
        }
    }
    
    public func TakeDamage(damage: Int){
        
    }
    
    
}
