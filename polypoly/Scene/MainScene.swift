//
//  TestScene.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/6/1.
//

import Foundation
import SpriteKit

class MainScene: SKScene, SKPhysicsContactDelegate{
    let screenCenter: CGPoint = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
    let screenLB: CGPoint = CGPoint(x: UIScreen.main.bounds.minX+100, y: UIScreen.main.bounds.minY + 50)

    //player variable
    var uuidDictionary = [Int: UUID]()
//    var uuidDictionary = [UUID: String]()
    var playerContainer = [Character]()
    var player1: Character!
    var player2: Character!
    var id1: UUID!
    var id2: UUID!
    var skillBtn: SkillButton!
    
    var ThisPlayer: Character!
//    var ThisUUID = UUID()
    override func sceneDidLoad() {
        CreatePlayer(numberOfperson: 2) //2 is for testing
        CreateCanvas()
        CreateSceneBound()

        CreatePowerBar()
        createResetButton()
        createAxis()
        
        self.zPosition = zAxis.Canvas
        physicsWorld.contactDelegate = self


        
    }
    func CreatePlayer(numberOfperson number: Int){
        let playerPosition = PlayerPositionFactory.create(numberOfperson: number).createPlayerPositions()
        for i in 0...number-1 {
            let id = UUID() //system assign a random string
            uuidDictionary[i] = id
            let character = CharacterFactory.shared.createCharacter(ID: id, position: playerPosition[i])
            playerContainer.append(character)
            addChild(character.ball)
        }
        ThisPlayer = playerContainer[0]
    }
    func CreateSceneBound() {
        let wall = Wall(size: self.size,position: screenCenter)
        wall.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        addChild(wall)
    }
    func CreatePowerBar() {
//        powerBar = PowerBar(position: CGPoint(x: self.frame.midX, y: 20),width: 300, height: 30, power: 100)
//        addChild(powerBar)
//        // add powerBar timer
//        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true, block: { [weak self] _ in
//                    guard let self = self else { return }
//                    self.powerBar.recoveryPower() // update the power bar display
//                })
    }
    func CreateCanvas(){
        let canvas = MainCanvas(thisPlayer: ThisPlayer)
        canvas.position = CGPoint(x: self.frame.minX, y: self.frame.minY)
        canvas.zPosition = zAxis.Canvas
        addChild(canvas)
    }
    
    override func didMove(to view: SKView) {
        skillBtn = SkillButton(user: ThisPlayer)
        skillBtn.position = screenLB
        skillBtn.zPosition = zAxis.skillButton
        self.addChild(skillBtn)
        let bgd = Background(image: "marble", position: screenCenter, rotate: 1.57)
                addChild(bgd)

    }
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody = SKPhysicsBody()
        var secondBody = SKPhysicsBody()

        if contact.bodyA.node?.name == "ball"{
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }
        else{
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        if(firstBody.node?.name == "ball" && secondBody.node?.name == "drawingLine"){
            print("collipse")
            if let drawingLine = secondBody.node as? DrawingLine {
                drawingLine.updateLineHp()
            }
        }
    }
    func didEnd(_ contact: SKPhysicsContact) {
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let touchLocation = touch.location(in: self)
            if ThisPlayer.ball.contains(touchLocation) {
                print("dragging")
            }
            if skillBtn.contains(touchLocation){
                print("skillBtn")
                skillBtn.touchesBegan(touches, with: event,from: ThisPlayer)
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    //---
    func createResetButton(){
        let resetButton = SKShapeNode(circleOfRadius: 10)
        resetButton.fillColor = .red
        resetButton.position = CGPoint(x: frame.midX, y: frame.minY+100)
        addChild(resetButton)
    }
    func createAxis(){
        //create xy axis
        let rect = SKShapeNode(rect: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        rect.strokeColor = .black
        rect.position = screenCenter
        addChild(rect)
    }

}
