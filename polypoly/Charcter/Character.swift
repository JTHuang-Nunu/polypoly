//
//  Character.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/5/24.
//

import Foundation

class Character: CharacterProtocol{
    var CharacterModelID: UUID
    var ball: Ball
    var lineList = [DrawingLine]()
    var currLine:DrawingLine!

    var position: CGPoint {
        didSet{// initial won't trigger didSet func
            ball.position = position
            print("ballposition: ",ball.position)
        }
    }
    init(characterModelID: UUID){
        self.CharacterModelID = characterModelID
        
        self.position = CGPoint(x: 0, y: 0)
        self.ball = Ball()
        self.ball.position = self.position
    }
    init(characterModelID: UUID, position: CGPoint){
        self.CharacterModelID = characterModelID
        
        self.position = position
        self.ball = Ball()
        self.ball.position = self.position
    }
    
    func DoAction(action: PlayerAction) {
        print("playerAction doing")
        switch(action.ActionType){
        case .UseSkill:
            self.UseSkill(action: action)
            break
        }
    }
    func UseSkill(action: PlayerAction){
        switch(action.Skill){
        case .Move:
            //self.move(impulse: action.content["impulse"])
            break
        default:
            break
        }
    }
    func move(impulse: CGVector) {
        pushBall(impulse: impulse)
    }
    func draw(status: TouchStatus, point: CGPoint?) {
        
        switch status {
        case .begin:
            let lineWidth: CGFloat = 10
            let hp: CGFloat = 3
            if let point = point {
                currLine = DrawingLine(startPoint: point, lineWidth: lineWidth, hp: CGFloat(hp))
                lineList.append(currLine)
            }
        case .move:
                if let point = point {
                    currLine.movePath(toPoint: point)
                }
            
        case .end:
            currLine.endDrawing()
        }
    }
    
    
    internal func pushBall(impulse: CGVector){
        self.ball.physicsBody?.applyImpulse(impulse)
//        self.scale = .zero
    }
}

