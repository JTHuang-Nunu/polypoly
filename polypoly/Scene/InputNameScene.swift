//
//  FirstScene.swift
//  polypoly
//
//  Created by mac03 on 2023/6/12.
//

import Foundation
import SpriteKit

class InputNameScene: SKScene, UITextFieldDelegate {
    let userNameKey = "userNameKey"
    var nameLabel: SKLabelNode!
    var textField: UITextField!
    var textFieldShape: SKShapeNode!
    var okButton: SKShapeNode!
    var buttonSound: SKAction!
    
    override func didMove(to view: SKView) {
        createBg()
        createInputBlock()
        createSound()
//        self.backgroundColor = .clear
    }
    func createBg(){
        self.backgroundColor = .white
    }
    func createSound(){
        if let soundURL = Bundle.main.url(forResource: "button_sound", withExtension: "mp3") {
            buttonSound = SKAction.playSoundFileNamed(soundURL.lastPathComponent, waitForCompletion: false)
        }
    }
    func createInputBlock(){
        //文字 Your name
        nameLabel = SKLabelNode(text: "Your name")
        nameLabel.position = ScreenCenter + CGPoint(0,100)
        nameLabel.fontColor = SKColor.black
        nameLabel.fontSize = 30
        addChild(nameLabel)
        
        // 生成文字輸入框
        let textFieldTxt = SKLabelNode(text: "Username")
        textFieldTxt.fontColor = SKColor.black
        textFieldTxt.fontSize = 25
//        textFieldTxt.horizontalAlignmentMode = .center
        textFieldTxt.verticalAlignmentMode = .center

        let rect =  CGRect(center: .zero, width: 380, height: 70)
        textFieldShape = SKShapeNode(rect: rect, cornerRadius: 20)
        textFieldShape.name = "shape"
        textFieldShape.fillColor = .gray
        textFieldShape.position = ScreenCenter
        textFieldShape.addChild(textFieldTxt)
        addChild(textFieldShape)
        
        //UITextField
        let textFieldView = TextFieldView(frame: rect)
        //確認textField有沒有被打開
        textFieldView.onTouch += moveTextField
        textField = textFieldView.textField
        //兩個都要加到目前的skview上
        view!.addSubview(textFieldView)
        view!.addSubview(textField)
//        textField.removeFromSuperview()
        
        //okbutton
        let okText = SKLabelNode(text: "OK")
        okText.name = "oktext"
        okText.fontName = "HelveticaNeue-Bold"
        okText.fontColor = SKColor.black
        okText.fontSize = 30
        okText.horizontalAlignmentMode = .center
        okText.verticalAlignmentMode = .center
        
        okButton = SKShapeNode(rect: CGRect(center: .zero, width: 70, height:70), cornerRadius: 10)
        okButton.name = "okbutton"
        okButton.fillColor = SKColor.white
        okButton.position = ScreenCenter + CGPoint(0,-115)
        okButton.strokeColor = UIColor(red: 150, green: 150, blue: 150, alpha: 1)
        let shadow = okButton.shadow()
        shadow.name = "shadow"
        
        okButton.addChild(shadow)
        okButton.addChild(okText)
        addChild(okButton)
        
    }
    
    func moveTextField(touched: Bool){
        let duration = 0.2
        if touched {    //move top
            textFieldShape.removeAllChildren()
            textFieldShape.run(SKAction.move(to: ScreenCenter + CGPoint(0, 55), duration: 0.5))
            nameLabel.run(SKAction.move(to: nameLabel.position + CGPoint(0, 20), duration: duration))
            
        } else {        //move down
            textFieldShape.run(SKAction.move(to: ScreenCenter, duration: 0.5))
            nameLabel.run(SKAction.move(to: nameLabel.position + CGPoint(0, -20), duration: duration))
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if let touch = touches.first {
            let touchLocation = touch.location(in: self)
            if okButton.contains(touchLocation){
                okButton.fillColor = UIColor(grayscale: 0.05)
                okButton.run(buttonSound!)
            }
        }
        if let touch = touches.first {
            let touchLocation = touch.location(in: view)
            if !textField.frame.contains(touchLocation) {
                view!.endEditing(true) // 收起鍵盤
            }
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let touchLocation = touch.location(in: self)
            // 檢查是否觸碰到指定的節點
            if okButton.contains(touchLocation){
                let factor = 0.3
                let displacement = CGVector(dx: touchLocation.x - okButton.position.x, dy: touchLocation.y - okButton.position.y) * factor
                // 反向的移動向量
                let reverseDisplacement = CGVector(dx: -displacement.dx, dy: -displacement.dy)
                
                // 創建一個移動的動作，使物體往反方向移動
                let moveAction = SKAction.move(by: reverseDisplacement, duration: 0.5)
                
                // 執行移動動作
                okButton.run(moveAction)
            }
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let touchLocation = touch.location(in: self)
            okButton.fillColor = .white
            if okButton.contains(touchLocation){
                if(textField.text!.count > 0){
                    let T = SKTransition.fade(withDuration: 0.5)
                    self.view?.presentScene(MenuScene(size: self.size), transition: T)
                } else{
                    textField.removeFromSuperview()
                    textFieldShape.run(shake())
                    print("empty")
                }
            }
        }
    }
    
    func shake() -> SKAction {
        let shakeLeft = SKAction.moveBy(x: -10, y: 0, duration: 0.1)
        let shakeRight = SKAction.moveBy(x: 10, y: 0, duration: 0.1)
        let shakeAction = SKAction.sequence([shakeLeft, shakeRight])

        let repeatShake = SKAction.repeat(shakeAction, count: 5)

        return repeatShake

    }
}
