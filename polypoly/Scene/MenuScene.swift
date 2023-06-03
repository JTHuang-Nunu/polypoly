
import UIKit
import SpriteKit
import AVFoundation

class MenuScene: SKScene {

    // 宣告選單元件
    private var userIDLabel: SKLabelNode!
    private var playButton: SKLabelNode!
    private var optionsButton: SKLabelNode!
    private var buttonSound: SKAction!
    private let userNameKey = "UserName" // 使用者名稱的鍵值
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        // 設定場景背景顏色
        backgroundColor = SKColor.white
        
        // 建立並設定選單元件
        createMenu()
        
        //設定按鈕音效
        if let soundURL = Bundle.main.url(forResource: "button_sound", withExtension: "mp3") {
            buttonSound = SKAction.playSoundFileNamed(soundURL.lastPathComponent, waitForCompletion: false)
        }
    }


    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 偵測觸碰事件
        
        
        for touch in touches {
            let location = touch.location(in: self)
            
            // 檢查是否點擊到 playButton
            if playButton.contains(location) {
                // 執行 playButton 按鈕相應的動作
                print("Play button tapped")
                
                // 添加縮放效果
                let scaleAction = SKAction.scale(to: 1.3, duration: 0.1)
                playButton.run(scaleAction) {
                    // 在完成縮放後執行其他動作或切換場景
                    self.showModeSelection()
                    self.playButtonSound()
                }
                
                //延遲Action
                let delayAction = SKAction.wait(forDuration: 0.1)
                //回覆原狀
                let scaleActionReset = SKAction.scale(to: 1.0, duration: 0.1)
                //執行動作
                let sequenceAction = SKAction.sequence([delayAction, scaleActionReset])
                playButton.run(sequenceAction)
                
            }
            
            // 檢查是否點擊到 optionsButton
            if optionsButton.contains(location) {
                // 執行 optionsButton 按鈕相應的動作
                print("Options button tapped")
                
                let scaleAction = SKAction.scale(to: 1.3, duration: 0.1)
                optionsButton.run(scaleAction) {
                    // 在完成縮放後執行其他動作或切換場景
                    self.showOptionsPopup()
                    self.playButtonSound()
                }
                
                //延遲Action
                let delayAction = SKAction.wait(forDuration: 0.1)
                //回覆原狀
                let scaleActionReset = SKAction.scale(to: 1.0, duration: 0.1)
                //執行動作
                let sequenceAction = SKAction.sequence([delayAction, scaleActionReset])
                optionsButton.run(sequenceAction)
            }
        }
        
        let defaults :UserDefaults = UserDefaults.standard
        if let userName = defaults.string(forKey: userNameKey), !userName.isEmpty {
            print("Welcome back, \(userName)!")
            showPlayerID(userName)
        } else {
            // 第一次打開程式，要求使用者輸入名稱
            print("need enter")
            askForUserName()
            let userName = defaults.string(forKey: userNameKey)
            showPlayerID(userName!)
        }
    }
    
    private func createMenu() {
        // 建立 playButton
        playButton = SKLabelNode(text: "Play")
        playButton.position = CGPoint(x: size.width / 2, y: size.height / 2 + 50)
        playButton.fontColor = SKColor.black
        playButton.setScale(1.0) // 設置初始縮放比例
        addChild(playButton)
        
        // 建立 optionsButton
        optionsButton = SKLabelNode(text: "Options")
        optionsButton.position = CGPoint(x: size.width / 2, y: size.height / 2 - 50)
        optionsButton.fontColor = SKColor.black
        addChild(optionsButton)
    }
    
    private func showModeSelection() {
        let alertController = UIAlertController(title: "選擇模式", message: "請選擇遊戲模式", preferredStyle: .actionSheet)
        
        let mode1Action = UIAlertAction(title: "高爾夫球模式", style: .default) { _ in
            // 執行模式1的相關動作
            
            print("模式1被選擇")
            
            if let view = self.view as SKView? {
                //todo 
                //let scene = MainScene(size: view.bounds.size)
                //scene.scaleMode = .aspectFill
                view.ignoresSiblingOrder = true
                view.showsFPS = true
                view.showsNodeCount = true
                //view.presentScene(scene)
            }
        }
        
        let mode2Action = UIAlertAction(title: "撞球模式", style: .default) { _ in
            // 執行模式2的相關動作
            
            print("模式2被選擇")
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel) { _ in
            // 取消選擇
            print("取消選擇")
        }
        
        alertController.addAction(mode1Action)
        alertController.addAction(mode2Action)
        alertController.addAction(cancelAction)
        
        if let viewController = self.view?.window?.rootViewController {
            viewController.present(alertController, animated: true, completion: nil)        }
    }
    
    private func showOptionsPopup() {
        let alertController = UIAlertController(title: "Options", message: nil, preferredStyle: .alert)

        // 建立音量滑桿
        let volumeSlider = UISlider()
        volumeSlider.minimumValue = 0.0
        volumeSlider.maximumValue = 1.0
        volumeSlider.value = AVAudioSession.sharedInstance().outputVolume
        alertController.view.addSubview(volumeSlider)

        // 調整音量
        let adjustVolumeAction = UIAlertAction(title: "Adjust Volume", style: .default) { _ in
            let volume = volumeSlider.value
            self.adjustVolume(volume)
        }
        alertController.addAction(adjustVolumeAction)

        // 取消
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        if let viewController = self.view?.window?.rootViewController {
            viewController.present(alertController, animated: true, completion: nil)
        }
    }

    private func adjustVolume(_ volume: Float) {
        // 執行調整音量的相關動作
        print("Volume adjusted: \(volume)")
        // 在這裡可以將調整後的音量應用到您的音效或背景音樂中
    }
    
    
    //顯示出玩家名稱
    private func showPlayerID(_ name: String) {
        // 建立 player name lable
        userIDLabel = SKLabelNode(text: "\(name)")
        userIDLabel.position = CGPoint(x: size.width - userIDLabel.frame.width/2 - 50, y: size.height - userIDLabel.frame.height/2 - 50)
        userIDLabel.fontColor = SKColor.black
        addChild(userIDLabel)
        
    }
    
    
    private func askForUserName() {
            let alertController = UIAlertController(title: "Welcome", message: "Please enter your username", preferredStyle: .alert)
            alertController.addTextField { textField in
                textField.placeholder = "Username"
            }
            
            let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                // 儲存使用者名稱
                if let textField = alertController.textFields?.first, let userName = textField.text {
                    UserDefaults.standard.set(userName, forKey: self.userNameKey)
                    print("Username saved: \(userName)")
                }
            }
            alertController.addAction(okAction)
            
            if let viewController = self.view?.window?.rootViewController {
                viewController.present(alertController, animated: true, completion: nil)
            }
        }
    
    //播放按鈕音效
    private func playButtonSound() {
        if let soundAction = buttonSound {
            playButton.run(soundAction)
        }
    }
}
