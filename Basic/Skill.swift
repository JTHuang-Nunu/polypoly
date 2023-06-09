//
//  Skill.swift
//  polypoly
//
//  Created by mac03 on 2023/5/31.
//

import Foundation

enum Skill: Codable {
    case Move
    case Obstacle                       //玩家畫圖建立障礙物        (CGPath)
    case Trap                           //玩家畫圖建立陷阱          (CGPoint)
    
    case MeteoriteFalling               //隕石砸落, 將場景物體破壞
    
    
    case HpRecovery                     //玩家HP恢復 (hp +?)
    case EnerergyRecovery                  //能量條恢復 (power +?)
    case TowerBuilding                  //建造塔型的物體
    case ObjectEnhancing                //下一個畫畫的物體增加血量
    case GravityIncreasing              //全場重力增加 (timer)
    case ObjectRandomlyGenerated        //物件隨機產生 (number of items)
}
