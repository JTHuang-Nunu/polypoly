//
//  File.swift
//  polypoly
//
//  Created by mac03 on 2023/6/2.
//

import Foundation
import SpriteKit



class SkillButton: SKShapeNode {
    var skill: Skill
    static var currSkill = Skill.Move
    var currentColor: UIColor = .cyan
    init(skillType : Skill = .Move, user: Character) {
        self.skill = skillType
        super.init()
        
        let buttonSize = CGSize(width: 50, height: 50)
        let buttonRect = CGRect(origin: CGPoint.zero, size: buttonSize)
        self.path = UIBezierPath(ovalIn: buttonRect).cgPath
        self.fillColor = currentColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//
//    func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?, from user: Character) {
//        SkillButton.currSkill = skill
//        user.currSkill = skill
//        skillSelected()
//    }
    
    func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?, from user: Character) {
        SkillButton.currSkill = skill
        user.currSkill = skill
        skillSelected()
    }
    
    private func skillSelected(){
        switch SkillButton.currSkill {
        case .Move:
            print("choose [move] skill")
            changeColor()
        case .Obstacle:
            break
        case .MeteoriteFalling:
            break
        case .HpRecovery:
            break
        // 其他技能的逻辑...
        case .PowerRecovery:
            break
        case .TowerBuilding:
            break
        case .ObjectEnhancing:
            break
        case .GravityIncreasing:
            break
        case .ObjectRandomlyGenerated:
            break
        default:
            break
        
        }
    }
    
    private func changeColor() {
        if currentColor == .cyan {
            currentColor = .gray
        } else {
            currentColor = .cyan
        }
        self.fillColor = currentColor
    }
}
