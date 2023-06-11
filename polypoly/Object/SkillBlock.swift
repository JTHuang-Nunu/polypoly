//
//  SkillBlock.swift
//  polypoly
//
//  Created by mac03 on 2023/6/6.
//

import Foundation
import SpriteKit

class SkillBlock: SKNode {
    public let OnSelectSkill: Event<Skill> = Event<Skill>()
    var skillButtons: [SkillButton] = []

    func addSkillButton(_ subSkill: Skill, user: Character) {
        //todo: complete it, now is temporary
        let skillBtn = MainSkillButton(skillType: .Move, skillType2: .Draw, user:user)
        addChild(skillBtn)
        
        let skillBtn2 = SkillButton(skillType: subSkill, user: user)
        skillBtn2.position = CGPoint(x:60, y:0)
        addChild(skillBtn2)
        skillButtons = [skillBtn,skillBtn2]
    }
    func resetAllSkill(currentBtn: SkillButton){
        for skillBtn in skillButtons{
            skillBtn.isSelected = false
        }
        if currentBtn == skillButtons[0]{
            currentBtn.isSelected = true
        }
    }
    
    init(subSkill: Skill, user: Character){
        super.init()
        addSkillButton(subSkill, user: user)
        SkillButton.OnSelectSkill += InputManager.shared.selectSkill
        _setupBody()
    }
    
    init(user: Character){
        super.init()
        let subSkill = user.possessSkill[2]
        addSkillButton(subSkill, user: user)
        SkillButton.OnSelectSkill += InputManager.shared.selectSkill
        _setupBody()
    }
    
    private func _setupBody(){
        let borderNode = SKShapeNode()
        let borderSize = CGSize(width: 200, height: 100)
//        let borderRect = CGRect(origin: CGPoint(x: -borderSize.width / 2, y: -borderSize.height / 2), size: borderSize)
        let borderRect = CGRect(origin: CGPoint(x: 0, y: 0), size: borderSize)
        borderNode.path = UIBezierPath(rect: borderRect).cgPath
        borderNode.lineWidth = 2
        borderNode.strokeColor = UIColor.yellow
        addChild(borderNode)
    }
    
    func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?, from user: Character) {
        guard let touch = touches.first else {return }
        let touchLocation = touch.location(in: self)
        for skillBtn in skillButtons{
            if skillBtn.contains(touchLocation){
                resetAllSkill(currentBtn: skillBtn)
                skillBtn.touchesBegan(touches, with: event,from: user)
                break
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
