//
//  PlayerController.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/5/24.
//

import Foundation
import UIKit

class InputManager: InputManagerProtocol{
    public static let shared = InputManager()
    
    func OnDoAction(action: (PlayerAction) -> Void) {
        
    }
    
    public func touchesBegan(touch: UITouch){
        print("touch")
    
    }
    public func touchesMoved(touch: UITouch){
        print("move")
    
    }
    public func touchesEnded(touch: UITouch){
        print("end")
    
    }
    
    
}