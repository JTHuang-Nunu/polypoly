//
//  TestScene.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/6/1.
//

import Foundation
import SpriteKit

class MainScene: SKScene, SKPhysicsContactDelegate{
    //player variable
    let gameManager = GameManager.shared
    var uuidDictionary = [Int: UUID]()
    var playerContainer = [Character]()
    var ThisCharacter: Character? = nil
    var ThisCanvas: Canvas? = nil
    var ThisUUID = UUID()
    //- - -
    var powerBar:PowerBar? = nil

//    var player1: Character!
//    var player2: Character!
//    var id1: UUID!
//    var id2: UUID!
    var skillBtn: SkillButton!

    override func sceneDidLoad() {
        gameManager._dispatcher.RequestRoom()
        CreatePlayers(numberOfperson: 2) //2 is for testing

        CreateCanvas()
        CreateSceneBound()

        CreatePowerBar()
        createResetButton()
        createAxis()
        createSkillBlock()
        self.zPosition = zAxis.Canvas
        physicsWorld.contactDelegate = self
    }
    func CreatePlayers(numberOfperson number: Int){
        //set [ThisCharacter]
//        ThisCharacter = gameManager.CreateCharacter(ID: ThisUUID)
//        ThisCharacter!.position = CGPoint(x: 0, y: 0)
//        self.addChild(ThisCharacter!.ball as SKNode)
//
//        gameManager.SetOperateCharacter(ID: ThisUUID)

        let playerPosition = PlayerPositionFactory.create(numberOfperson: number).createPlayerPositions()
        for i in 0...number-1 {
            let character = gameManager.CreateCharacter(ID: ThisUUID)
            character.position = playerPosition[i]
            playerContainer.append(character)
            addChild(character.ball)
        }
        //set ThisCharacter
        gameManager.SetOperateCharacter(ID: gameManager.GetCharacterMap().first!.key)
        ThisCharacter = gameManager.GetCharacterMap().first!.value
    }
    func CreateSceneBound() {
        let wall = Wall(size: UIScreen.main.bounds.size)
        wall.position = ObjectPosition.BoundWall
        addChild(wall)
    }
    func CreatePowerBar() {
        let ThisCharacterPower = ThisCharacter!.getPower()
        powerBar = PowerBar(position: ObjectPosition.PowerBar, power: ThisCharacterPower)
        ThisCharacterPower.setPowerBar(bar: powerBar!)
        powerBar!.position = ObjectPosition.PowerBar
        addChild(powerBar!)
    }
    func CreateCanvas(){
        ThisCanvas = Canvas(pointerStartNode: ThisCharacter!.ball)
        ThisCanvas!.OnDrawPointer += InputManager.shared.InputPointer
        addChild(ThisCanvas! as SKNode)
    }

    override func didMove(to view: SKView) {
        let bgd = Background(image: "marble", position: ObjectPosition.Center, rotate: 1.57)
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


//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let touch = touches.first {
//            let touchLocation = touch.location(in: self)
//            if ThisPlayer.ball.contains(touchLocation) {
//                print("dragging")
//            }
//            if skillBtn.contains(touchLocation){
//                print("skillBtn")
//                skillBtn.touchesBegan(touches, with: event,from: ThisPlayer)
//            }
//        }
//    }
//
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//
//    }
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
        rect.position = ObjectPosition.Center
        addChild(rect)
    }
    func createSkillBlock(){
        skillBtn = SkillButton(user: ThisCharacter!)
        skillBtn.position = ObjectPosition.SkillBlock
        skillBtn.zPosition = zAxis.skillButton
        self.addChild(skillBtn)
    }

}
