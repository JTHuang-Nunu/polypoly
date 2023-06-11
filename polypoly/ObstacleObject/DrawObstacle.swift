//
//  DrawObstacle.swift
//  polypoly
//
//  Created by mac03 on 2023/6/10.
//

import Foundation
import SpriteKit

class DrawObstacle: ObstacleObejct {
    var path: CGPath? = nil
    init(position: CGPoint){
        //temporary: Demo Path
        let path = CGMutablePath()
        // 將頂點連接起來
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 100))
        path.addLine(to: CGPoint(x: 100, y: 100))
        path.addLine(to: CGPoint(x: 100, y: 0))
        path.closeSubpath()
        
        self.path = path
        super.init(node: SKShapeNode(path: self.path!))
        self.position = position
        self._setupBody()
    }
    
    init(position: CGPoint, path: CGPath){
        self.path = path
        super.init(node: SKShapeNode(path: self.path!))
        self.position = position
        self._setupBody()
    }
    
    private func _setupBody(){
        self.name = "drawObstacle"
        //node setting
        node.strokeColor = .orange
        node.fillColor = .yellow
        
        //physics setting
        self.physicsBody = SKPhysicsBody(polygonFrom: path!)
        self.physicsBody?.mass = PhysicsMass.DrawObstacle
        self.physicsBody?.restitution = 0.2
        self.physicsBody?.friction = 0.2
        
        //health point setting
        healthManager.initHP(maxHP: 1)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//------
//Physical Body:
//如果使用 self.physicsBody = SKPhysicsBody(polygonFrom: path) 可以有碰撞 彈開
//但如果使用 self.physicsBody = SKPhysicsBody(edgeLoopFrom: path) 可以有碰撞回饋 但不會彈開 蠻奇妙的
