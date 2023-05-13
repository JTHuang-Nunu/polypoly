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
  
        class playerdata: Codable{
            var health: Int = 100
            var name = "Alan"
        }
        var sessionManager = SesstionManager(host: NWEndpoint.hostPort(host: "172.20.10.5", port: 8000))
        
        sessionManager.sendData(message: "hello world")
        sessionManager.sendData(message: "hello TCP", reliable: true)
        sessionManager.sendObject(object: playerdata(),reliable: true)
        
        if let view = self.view as! SKView? {
//            let scene = initialScene(size: view.bounds.size)
            let scene = MainScene(size: view.bounds.size)
            scene.scaleMode = .aspectFill
            view.presentScene(scene)
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
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
