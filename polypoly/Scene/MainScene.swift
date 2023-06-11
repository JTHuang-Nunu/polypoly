////
////  TestScene.swift
////  polypoly
////
////  Created by Cheng Pong Huang on 2023/6/1.
////
//
//import Foundation
//import SpriteKit
//
//class MainScene: SKScene, SKPhysicsContactDelegate{
//    let gameManager = DeviceManager.shared.GameManager!
//    let _statsManager = StatsManager.shared
//    var uuidDictionary = [Int: UUID]()
//    var playerContainer = [Character]()
//    var ThisCharacter: Character? = nil
//    var ThisCanvas: MainCanvas? = nil
//    var ThisUUID = UUID()
//    let myPoint = CGPoint(x: 50, y: 0)
//    let othersPoint = CGPoint(x: -50, y: 0)
//    
//    var ThisCanvas: Canvas? = nil
//    var operateCharacter: Character? = nil
//    //- - -
//    var powerBar:PowerBar? = nil
//
////    var player1: Character!
////    var player2: Character!
////    var id1: UUID!
////    var id2: UUID!
////    var skillBlock: SkillBlock!
//
//    override func sceneDidLoad() {
//        CreatePlayers()
//        CreateCanvas()
//        CreateSceneBound()
//
//        CreatePowerBar()
//        createResetButton()
//        createAxis()
////        createSkillBlock()
//        self.zPosition = zAxis.Canvas
//        physicsWorld.contactDelegate = self
//        physicsWorld.gravity = CGVector(dx: 0.0, dy: 0.0)
//        
//        //test obstacle object
////        let tmp = BuildingObstacle(position: CGPoint(x: 0, y: 0))
//////        addChild(tmp)
////        let tmp2 = DrawObstacle(position: CGPoint(x: 0, y: 0))
////        addChild(tmp2)
//        let tmp = ObstacleObejctFactory()
////        tmp.create(type: .Building, position: CGPoint(x: 0, y: 0))
//        addChild(tmp.create(type: .Building, position: CGPoint(x: 0, y: 0)))
//    }
//    func CreatePlayers(){
//        let players = gameManager.GetCharacterMap()
//        for id in players.keys{
//            switch gameManager.IfSameDirectionWithOperateCharacter(id: id){
//            case true:
//                let character = players[id]
//                character?.ball.position = myPoint
//                addChild(character!.ball)
//                break
//            case false:
//                let character = players[id]
//                character?.ball.position = othersPoint
//                addChild(character!.ball)
//            default:
//                break
//            }
//        }
//    
//    }
//
//    func CreateSceneBound() {
//        let wall = Wall(size: UIScreen.main.bounds.size)
//        wall.position = ObjectPosition.BoundWall
//        addChild(wall)
//    }
//    func CreatePowerBar() {
//        let ThisCharacterPower = ThisCharacter!.getPower()
//        powerBar = PowerBar(position: ObjectPosition.PowerBar, power: ThisCharacterPower)
//        ThisCharacterPower.setPowerBar(bar: powerBar!)
//        powerBar!.position = ObjectPosition.PowerBar
//        addChild(powerBar!)
//    }
//    func CreateCanvas(){
//        ThisCanvas = MainCanvas(startNode: operateCharacter!.ball)
//        gameManager._inputManager.SetCanvas(canvas: ThisCanvas!)
//        addChild(ThisCanvas! as SKNode)
//    }
//
//    override func didMove(to view: SKView) {
//        let bgd = Background(image: "marble", position: ObjectPosition.Center, rotate: 1.57)
//                addChild(bgd)
//
//    }
//    func didBegin(_ contact: SKPhysicsContact) {
//        var firstBody = SKPhysicsBody()
//        var secondBody = SKPhysicsBody()
//
//        if contact.bodyA.node?.name == "ball"{
//            firstBody = contact.bodyA
//            secondBody = contact.bodyB
//        }
//        else{
//            firstBody = contact.bodyB
//            secondBody = contact.bodyA
//        }
//        if(firstBody.node?.name == "ball" && secondBody.node?.name == "building"){
//            print("collipse")
//            if let building = secondBody.node as? BuildingObstacle{
//                building.updateHP(val: 1, type: .Injure)
//            }
//        }
//        if(firstBody.node?.name == "ball" && secondBody.node?.name == "drawObstacle"){
//            print("drawOB")
//
//            if let building = secondBody.node as? DrawObstacle{
//                building.updateHP(val: 1, type: .Injure)
//            }
//        }
//        
//        //touch charact is a
////        healthManager.TakeDamage(who: , damage: <#T##Int#>)
//    }
//    func didEnd(_ contact: SKPhysicsContact) {
//    }
//
//
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let touch = touches.first {
//            let touchLocation = touch.location(in: self)
////            if skillBlock.contains(touchLocation){
////                skillBlock.touchesBegan(touches, with: event, from: ThisCharacter!)
////            }
//        }
//    }
////
////    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
////
////    }
//    //---
//    func createResetButton(){
//        let resetButton = SKShapeNode(circleOfRadius: 10)
//        resetButton.fillColor = .red
//        resetButton.position = CGPoint(x: frame.midX, y: frame.minY+100)
//        addChild(resetButton)
//    }
//    func createAxis(){
//        //create xy axis
//        let rect = SKShapeNode(rect: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
//        rect.strokeColor = .black
//        rect.position = ObjectPosition.Center
//        addChild(rect)
//    }
//    func CreateSkills(){
//        let skillButtons = gameManager._skillManager?.skillButtons
//        for i in 0..<skillButtons!.count{
//            let skill = skillButtons![i]
//            skill.position = CGPoint(x:self.frame.minX + 50 + CGFloat(100*i), y:self.frame.midY)
//            skill.zPosition = zAxis.skillButton
//            addChild(skill as SKNode)
//            
//        }
//    }
//    override func update(_ currentTime: TimeInterval) {
//        _update(currentTime)
//    }
// }
