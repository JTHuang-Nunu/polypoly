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
import AVFoundation
class GameViewController: UIViewController, UITextFieldDelegate {
    var backgroundMusicPlayer: AVAudioPlayer?
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
        setbackgroundMusic()
        playBackgroundMusic()
        if let view = self.view as! SKView? {
            //            let scene = MenuScene(size: view.bounds.size)
            //            let scene = FirstScene(size: view.bounds.size)
//            let scene = InputNameScene(size: view.bounds.size)
            let scene = InitialScene(size: view.bounds.size)
//            let scene = HomeScene(size: view.bounds.size)
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
    func setbackgroundMusic(){
        if let backgroundMusicURL = Bundle.main.url(forResource: "Cipher2", withExtension: "mp3") {
            do {
                backgroundMusicPlayer = try AVAudioPlayer(contentsOf: backgroundMusicURL)
                backgroundMusicPlayer?.numberOfLoops = -1 // -1表示無限循環播放
                backgroundMusicPlayer?.prepareToPlay()
            } catch {
                print("無法初始化背景音樂播放器: \(error.localizedDescription)")
            }
        }
    }
    
    // 在需要播放背景音樂的地方調用此方法
    func playBackgroundMusic() {
        backgroundMusicPlayer?.play()
    }
}
