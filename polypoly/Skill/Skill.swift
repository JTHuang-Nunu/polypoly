//
//  Skill.swift
//  polypoly
//
//  Created by mac03 on 2023/5/31.
//

import Foundation

enum SkillList {
    case MeteoriteFalling               //隕石砸落, 將場景物體破壞
    case HpRecovery                     //玩家HP恢復 (hp +?)
    case PowerRecovery                  //能量條恢復 (power +?)
    case TowerBuilding                  //建造塔型的物體
    case ObjectEnhancing                //下一個畫畫的物體增加血量
    case GravityIncreasing              //全場重力增加 (timer)
    case ObjectRandomlyGenerated        //物件隨機產生 (number of items)
}

protocol Skill {
    var skillID: Int { get }    ///maybe not needed
    func perform()
}

class MeteoriteFalling: Skill {
    let skillID: Int
    
    init(skillID: Int) {
        self.skillID = skillID
    }
    
    func perform() {
        print("Using MeteoriteFalling")
    }
}

class HpRecovery: Skill {
    func perform() {
        print("Using HpRecovery")
    }
    
    let skillID: Int
    
    init(skillID: Int) {
        self.skillID = skillID
    }
}
