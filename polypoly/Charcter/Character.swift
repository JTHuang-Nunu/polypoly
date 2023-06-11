//
//  Character.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/5/24.
//

import Foundation

class Character: CharacterProtocol{
    var OnUpdateStats: Event<(CGFloat?, CGFloat?, StatsType)> = Event<(CGFloat?, CGFloat?, StatsType)>()
    
    var hp: CGFloat = 100
    var CharacterModelID: UUID
    var ball: Ball = Ball()
    var lineList = [DrawingLine]()
    var currLine:DrawingLine!
    var possessSkill: [Skill] = [.Move, .Draw, .GravityIncreasing]
    var currSkill: Skill = .Move  {
        didSet {
            print("Character be setting \(String(describing: currSkill))")
        }			
    }
    internal var power: Power = Power(CharacterPower: 100)

    var position: CGPoint {
        didSet{// initial won't trigger didSet func
            ball.position = position
            print("ballposition: ",ball.position)
        }
    }
    init(characterModelID: UUID){
        self.CharacterModelID = characterModelID
        self.position = CGPoint(x: 0, y: 0)
        self._setup()
    }
    
    init(characterModelID: UUID, position: CGPoint){
        self.CharacterModelID = characterModelID
        self.position = position
        self._setup()
    }
    private func _setup(){
        self.ball.position = self.position
        OnUpdateStats += InputManager.shared.updatePlayerStats
    }

    func DoAction(action: PlayerAction) {
        print("playerAction doing")
        switch action.ActionType{
        //Use skill
        case .UseSkill:
            switch action.Skill{
            case .Move:
                characterMove(content: action.content)
            case .Obstacle:
                break
            case .Trap:
                break
            case .Draw:
                break
            case .MeteoriteFalling:
                break
            case .HpRecovery:
                break
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
            case .bomp:
                break

            }
        //Choose skill
        case .ChooseSkill:
            currSkill = action.Skill
        }
    }
    
    func characterMove(content : [ContentType: String]) {
        guard var impulse = decodeJSON(CGVector.self, jsonString: content[.Impulse]!)
        else {return}
        //- - -
        //update Power //modify impulse , when power value is insufficient
        let distance = impulse.distance
        
        var transformToPower: CGFloat{
            return distance / 5
        }
        print(distance)
        print("origin impulse", impulse)
        var currPower = self.power.getCurrentValue()
        if(currPower < transformToPower){
            let modifyImpulse = currPower / transformToPower
            impulse = impulse * modifyImpulse
            currPower = 0 // using  all power
        } else{
            currPower -= transformToPower
        }
        print("modify impulse", impulse)
//        OnUpdateStats.Invoke((nil ,currPower, .Energy))
        OnUpdateStats.Invoke((0 ,currPower, .All))
        //- - -
        //push the ball by the impulse
        self.ball.physicsBody?.applyImpulse(impulse)
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
    
    
    func getPower() -> Power {
        return self.power
    }
}

