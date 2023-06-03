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
class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // wait 2 seconds and send playeraction

//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            let action = PlayerAction(CharacterModelID: UUID(), ActionType: .ChooseAbility, AbilityID: 1, ActionTime: Date())
//            
//            dispatcher.sendAction(action: action)
//        }
        
        if let view = self.view as! SKView? {
//            let scene = initialScene(size: view.bounds.size)
            let scene = TestScene(fileNamed: "TestScene copy")!
            scene.scaleMode = .aspectFill
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
            view.presentScene(scene)
        }
        
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
//        if let scene = GKScene(fileNamed: "GameScene") {
//
//            // Get the SKScene from the loaded GKScene
//            if let sceneNode = scene.rootNode as! GameScene? {
//
//                // Copy gameplay related content over to the scene
//                sceneNode.entities = scene.entities
//                sceneNode.graphs = scene.graphs
//
//                // Set the scale mode to scale to fit the window
//                sceneNode.scaleMode = .aspectFill
//
//                // Present the scene
//                if let view = self.view as! SKView? {
//                    view.presentScene(sceneNode)
//
//                    view.ignoresSiblingOrder = true
//
//                    view.showsFPS = true
//                    view.showsNodeCount = true
//                }
//            }
//        }
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
}
