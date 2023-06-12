//
//  GameViewController.swift
//  polypoly
//
//  Created by mac03 on 2023/4/30.
//

import UIKit
import SpriteKit
import GameplayKit
import Network
class GameViewController: UIViewController, UITextFieldDelegate {
//    override var preferredScreenEdgesDeferringSystemGestures: UIRectEdge{ //下方手勢推遲
//        return [.bottom]
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // wait 2 seconds and send playeraction
        
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        //            let action = PlayerAction(CharacterModelID: UUID(), ActionType: .ChooseAbility, AbilityID: 1, ActionTime: Date())
        //
        //            dispatcher.sendAction(action: action)
        //        }
        
        if let view = self.view as! SKView? {
            //            let scene = MenuScene(size: view.bounds.size)
            //            let scene = FirstScene(size: view.bounds.size)
            let scene = InputNameScene(size: view.bounds.size)
            //            let scene = TestScene2(size: view.bounds.size)
            
            //            setNeedsUpdateOfScreenEdgesDeferringSystemGestures()
            scene.scaleMode = .aspectFill
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
            view.presentScene(scene)
            
            
        }
        
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
            // 處理 UITextField 開始編輯的事件
            // 在這裡你可以執行相應的動作，例如移動場景中的元素
            print("TextField did begin editing")
        }
}


extension GameScene: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("hello")
//        // 計算需要移動的距離
//        let keyboardHeight: CGFloat = 300 // 假設鍵盤高度為 300
//        let textFieldBottomY = textField.frame.origin.y + textField.frame.size.height
//        let distanceToMove = textFieldBottomY - (size.height - keyboardHeight)
//        
//        // 如果需要移動，則調整場景中所有元素的位置
//        if distanceToMove > 0 {
//            // 創建一個移動的動作，將場景中所有元素往上移動指定距離
//            let moveAction = SKAction.moveBy(x: 0, y: distanceToMove, duration: 0.3)
//            
//            // 執行移動動作
//            self.run(moveAction)
//        }
    }
}
