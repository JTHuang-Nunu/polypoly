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
//            let scene = InputNameScene(size: view.bounds.size)
            let scene = HomeScene(size: view.bounds.size)
//                        let scene = TestScene2(size: view.bounds.size)
            
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
