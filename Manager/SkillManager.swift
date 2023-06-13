//
//  SkillManager.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/6/7.
//

import Foundation
import SpriteKit

//目前skill list 會從gamem manager call in
class SkillManager{
    public let OnSelectSkill = Event<Skill>()
    public var currentSkill: Skill? = nil
    private let skillList: [Skill]
    public var skillButtons: [SkillSelectButton] = []

    private let btnRadius: CGFloat = 30.0
    
    public init(skills: [Skill]){
        skillList = skills
        buildSkillButtons()
        OnSelectSkill += { skill in
            self.currentSkill = skill   //如果被invoke到的時候 會儲存skill為current skill
            for s in self.skillButtons{
                if (s.SelfSkill == self.currentSkill){
                    s.OnBeganSelect.Invoke(())
                }else {
                    s.OnEndedSelect.Invoke(())
                }
            }
        }
    }
    private func buildSkillButtons(){
        for skill in skillList{
            let button = SkillSelectButton(skill: skill, radius: btnRadius)
            button.OnSelectSkill += OnSelectSkill.Invoke
            skillButtons.append(button)
        }
    }
    public func SetDefaultSkill(skill: Skill){
        OnSelectSkill.Invoke(skill)
    }

}
//------------------------------------------------------
//------------------------------------------------------
class SkillSelectButton: BaseButton{
    public let OnSelectSkill = Event<Skill>()
    public let OnEndedSelect = Event<Void>()
    public let OnBeganSelect = Event<Void>()
    public let SelfSkill: Skill
    private var btnRadius: CGFloat         //get from SkillManager
    private var glowNode: SKShapeNode!    // 用於閃爍特效的節點
    
    init(skill: Skill, radius: CGFloat) {
        btnRadius = radius
        SelfSkill = skill
        super.init()
        
        OnClickBegin += {
            self.OnSelectSkill.Invoke(self.SelfSkill)
        }
        OnBeganSelect += addGlowEffect
        OnEndedSelect += removeGlowEffect
        _setSkillUI()
        _setGlowNode()
    }
    private func _setSkillUI(){
        let btnSize = CGSize(width: btnRadius * 2, height: btnRadius * 2)
        let btnNode = SKSpriteNode(texture: nil, size: btnSize)
        var btnIcon: SKTexture?
        // take Icon image from resource
        switch SelfSkill {
        case .Move:
            btnIcon = SKTexture(imageNamed: "skill_move")
        case .Obstacle:
            btnIcon = SKTexture(imageNamed: "skill_draw")
        case .Trap:
            btnIcon = SKTexture(imageNamed: "skill_trap")
        case .TowerBuilding:
            btnIcon = SKTexture(imageNamed: "skill_building")
        
        default:
            break
        }
        
        // Setting btnIcon to btnNode
        guard let btnIcon = btnIcon else {
            print("[\(String(describing: SelfSkill))] isn't setting icon")
            addChild(btnNode)
            return
        }
        btnNode.texture = btnIcon
        addChild(btnNode)
    }
    private func _setGlowNode(){
        let nodeOffset = 0.0
        let nodeRadius = btnRadius + nodeOffset
        
        glowNode = SKShapeNode(circleOfRadius: nodeRadius)
        glowNode.fillColor = .yellow
        glowNode.zPosition = 1
        glowNode.alpha = 0 // 初始時透明度為 0，不可見
//        glowNode.
        addChild(glowNode)
    }
    //-----------
    //glow effect
    private func addGlowEffect() {
        let duration = 0.5
        let fadeIn = SKAction.fadeAlpha(to: 0.4, duration: duration)
        let fadeOut = SKAction.fadeAlpha(to: 0.0, duration: duration)
        let fade = SKAction.sequence([fadeIn, fadeOut])
        
        let scaleIn = SKAction.scale(to: 0.6, duration: duration)
        let scaleOut = SKAction.scale(to: 1.0, duration: duration)
        let scale = SKAction.sequence([scaleIn, scaleOut])
        let group = SKAction.group([fade, scale])
        let repeatPulse = SKAction.repeatForever(group)
        
        glowNode.run(repeatPulse)
    }
    internal func removeGlowEffect(){
        glowNode.removeAllActions()
        glowNode.alpha = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//------------------------------------------------------
//------------------------------------------------------
