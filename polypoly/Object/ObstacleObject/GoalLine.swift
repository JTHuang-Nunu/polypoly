//
//  GoalLine.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/6/13.
//

import Foundation
import SpriteKit


class GoalLine: SKShapeNode {
    public let OnGoal = Event<Void>()
    let color: UIColor!
//    override init() {
//        super.init()
//        self.name = "goalline"
//        let tmp = SKShapeNode(circleOfRadius: 10)
//        tmp.fillColor = .yellow
//        self.addChild(tmp)
//        self.path = CGPath(rect: CGRect(x: -25, y: -50, width: 50, height: 100), transform: nil)
//        fillColor = .blue
//        strokeColor = .blue
//
//        physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 100))
//        physicsBody!.isDynamic = true
//        physicsBody!.categoryBitMask = PhysicsCategory.GoalLine
//        physicsBody!.collisionBitMask = 0
//        physicsBody!.contactTestBitMask = PhysicsCategory.Ball
//    }
    init(color: UIColor) {
        self.color = color
        super.init()
        self.name = "goalline" //*** important
        var size = CGSize(width: 40, height: 140)
        let cornerRadius: CGFloat = 20
        let roundedRectPath = UIBezierPath(roundedRect: CGRect(origin: CGPoint(-20, -70), size: size), cornerRadius: cornerRadius)
        self.path = roundedRectPath.cgPath
        self.strokeColor = .clear
        size = CGSize(width: 10, height: 140)
        physicsBody = SKPhysicsBody(rectangleOf: size, center: CGPoint(x: 0, y: 0))
        physicsBody!.isDynamic = true
        physicsBody!.categoryBitMask = PhysicsCategory.GoalLine
        physicsBody!.collisionBitMask = 0
        physicsBody!.contactTestBitMask = PhysicsCategory.Ball
        showGoalline()
//        addGoalline()
//        addGlowEffect()
    }
    private func showGoalline(){
        let size = CGSize(width: 10, height: 140)
        let cornerRadius: CGFloat = 20
        let roundedRectPath = UIBezierPath(roundedRect: CGRect(origin: CGPoint(-20, -70), size: size), cornerRadius: cornerRadius)
        let t = SKShapeNode()
        t.path = roundedRectPath.cgPath
        t.fillColor = color
        t.strokeColor = .black
        
        t.position = CGPoint(15, 0)

        self.addChild(t)
        let fadeIn = SKAction.fadeAlpha(to: 1.0, duration: 0.6)
        let fadeOut = SKAction.fadeAlpha(to: 0.6, duration: 0.6)
        let fade = SKAction.sequence([fadeOut, fadeIn])
        let repeatPulse = SKAction.repeat(fade, count: 5)
        t.run(SKAction.sequence([repeatPulse]))
    }
    private func addGoalline() {
        // Create a random color action
        let randomColorAction = SKAction.run {
            let randomColor = UIColor(red: .random(in: 0.5...1), green: .random(in: 0.5...1), blue: .random(in: 0.5...1), alpha: 1.0)
            self.fillColor = randomColor
        }

        // Repeat the random color action indefinitely
        let colorAction = SKAction.repeatForever(SKAction.sequence([
            randomColorAction,
            SKAction.wait(forDuration: 1.0) // Delay between color changes
        ]))

        self.run(colorAction)
    }
    private func addGlowEffect() {
        let duration = 1.0
        let fadeIn = SKAction.fadeAlpha(to: 1.0, duration: duration)
        let fadeOut = SKAction.fadeAlpha(to: 0.6, duration: duration)
        let fade = SKAction.sequence([fadeIn, fadeOut])
        
//        let group = SKAction.group([fade, scale])
        let repeatPulse = SKAction.repeatForever(fade)
        
        self.run(repeatPulse)
    }
    
    public func Goal(){
        OnGoal.Invoke(())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
