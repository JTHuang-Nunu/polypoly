//
//  SkillFactory.swift
//  polypoly
//
//  Created by mac03 on 2023/5/31.
//

import Foundation

class SkillFactory {
    func getSkill(skillNo: SkillList) -> Skill{
        switch skillNo{
        case .MeteoriteFalling:
            return MeteoriteFalling(skillID: 123)
        case .HpRecovery:
            return HpRecovery(skillID: 123)
        case .PowerRecovery:
            fallthrough
        case .TowerBuilding:
            fallthrough
        case .ObjectEnhancing:
            fallthrough
        case .GravityIncreasing:
            fallthrough
        case .ObjectRandomlyGenerated:
            fallthrough
        default:
            print("didn't choose a skill")
            return Skill.self as! Skill
        }
    }
}
