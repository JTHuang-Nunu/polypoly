//
//  SkillManager.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/6/7.
//

import Foundation
import SpriteKit

class SkillManager{
    public let OnSelectSkill = Event<Skill>()
    
    public var currentSkill: Skill? = nil
    private let skillList: [Skill]
    public var skillButtons: [SkillSelectButton] = []
    public init(skills: [Skill]){
        skillList = skills
        buildSkillButtons()
        OnSelectSkill += { skill in
            self.currentSkill = skill
        }
    }
    private func buildSkillButtons(){
        for skill in skillList{
            let button = SkillSelectButton(skill: skill)
            button.OnSelectSkill += OnSelectSkill.Invoke
            skillButtons.append(button)
        }
    }
    public func SetSkill(skill: Skill){
        currentSkill = skill
        OnSelectSkill.Invoke(skill)
    }
    
}
//------------------------------------------------------
class SkillSelectButton: BaseButton{
    public let OnSelectSkill = Event<Skill>()
    public let SelfSkill: Skill
    init(skill: Skill) {
        SelfSkill = skill
        super.init()
        let square = SKShapeNode(rectOf: CGSize(width: 50, height: 50))
        square.fillColor = .blue
        square.strokeColor = .blue
        
        addChild(square)
        OnClickBegin += {
            self.OnSelectSkill.Invoke(self.SelfSkill)
        }
        
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
