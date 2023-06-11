//
//  File.swift
//  polypoly
//
//  Created by mac03 on 2023/6/2.
//

import Foundation
import SpriteKit
//------------------------------------------------//
//               SkillButton
//------------------------------------------------//
class SkillButton: SKShapeNode {
    static let OnSelectSkill: Event<Skill> = Event<Skill>()
    var skill: Skill
    var isSelected: Bool = false {
        didSet {
            if isSelected == true {
                flashingBorder.startFlashing()
            } else{
                flashingBorder.stopFlashing()
            }
        }
    }
    var flashingBorder: FlashingBorder!
    var buttonSize: CGSize = CGSize(width: 50, height: 50)
    var currentColor: UIColor = .green {
        didSet{
            self.fillColor = currentColor
        }
    }
    var labelNode: SKLabelNode
    
    init(skillType : Skill = .Move, user: Character) {
        self.skill = skillType
        self.labelNode = SKLabelNode(text: "\(String(describing: skill).first!)")
        self.flashingBorder = FlashingBorder(size: buttonSize)
        super.init()
        self._setupBody()
    }
    private func _setupBody(){
        self.zPosition = zAxis.skillButton
        //set label
        labelNode.position = CGPoint(x: 0, y: 0)
        labelNode.fontSize = 30
        labelNode.fontColor = .black
        addChild(labelNode)
        //set button color
        let buttonRect = CGRect(origin: CGPoint.zero, size: buttonSize)
        self.path = UIBezierPath(ovalIn: buttonRect).cgPath
        self.fillColor = currentColor
        //set flashingBorder
        addChild(flashingBorder)
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
    
//    private func skillSelected(){
//        switch SkillButton.currSkill {
//        case .Move:
//            print("choose [move] skill")
//            changeColor()
//        case .Draw:
//            break
//        case .MeteoriteFalling:
//            break
//        case .HpRecovery:
//            break
//        // 其他技能的逻辑...
//        case .PowerRecovery:
//            break
//        case .TowerBuilding:
//            break
//        case .ObjectEnhancing:
//            break
//        case .GravityIncreasing:
//            break
//        case .ObjectRandomlyGenerated:
//            break
//        default:
//            break
//
//        }
//    }
    
    private func changeColor() {
        if currentColor == .cyan {
            currentColor = .gray
        } else {
            currentColor = .cyan
        }
        self.fillColor = currentColor
    }
}
//------------------------------------------------//
//               MainSkillButton
//------------------------------------------------//
//class MainSkillButton: SkillButton {
//    var skill2: Skill
//    var currSkill: Skill
//    init(skillType: Skill = .Move, skillType2: Skill = .Draw, user: Character) {
//        self.skill2 = skillType2
//        self.currSkill = skillType
//        super.init(skillType: skillType, user: user)
//        self.currentColor = .red
//        self.fillColor = currentColor
//        
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?, from user: Character) {
//        if(isSelected){
//            if(currSkill == skill){
//                currSkill = skill2
//                labelNode.text? = (String(describing: currSkill).first)!.description
//                self.currentColor = .blue
//            } else if(currSkill == skill2){
//                currSkill = skill
//                labelNode.text? = (String(describing: currSkill).first)!.description
//                self.currentColor = .red
//            }
//        } else{
//            isSelected = true
//        }
//        
//        SkillButton.OnSelectSkill.Invoke(currSkill)
//    }
//}
//------------------------------------------------//
//                  FlashingBorder
//------------------------------------------------//
class FlashingBorder: SKShapeNode {
    var isFlashing: Bool = false
    private let borderNode = SKShapeNode()
    var borderSize: CGSize!
    var flashAction = SKAction()
    init(size: CGSize){
        borderSize = size
        super.init()
    }
    // 开始闪烁边框
    func startFlashing() {
        // 检查是否已经在闪烁中
        guard !isFlashing else { return }
//        let borderRect = CGRect(origin: CGPoint(x: -borderSize.width/2, y: -borderSize.height/2), size: borderSize)
        let borderRect = CGRect(origin: .zero, size: borderSize)
        borderNode.path = UIBezierPath(ovalIn: borderRect).cgPath
        borderNode.lineWidth = 2
        borderNode.strokeColor = UIColor.red
        addChild(borderNode)
        
        // 创建闪烁动作
        let fadeOutAction = SKAction.fadeOut(withDuration: 0.5)
        let fadeInAction = SKAction.fadeIn(withDuration: 0.5)
        flashAction = SKAction.repeatForever(SKAction.sequence([fadeOutAction, fadeInAction]))
        
        // 执行闪烁动作
        borderNode.run(flashAction)
        
        isFlashing = true
    }
    
    // 停止闪烁边框
    func stopFlashing() {
        // 检查是否在闪烁中
        guard isFlashing else { return }
        
        // 停止闪烁动作并移除边框节点
        borderNode.removeAllActions()
        borderNode.removeFromParent()
        
        isFlashing = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
