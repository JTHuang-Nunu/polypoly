//
//  PlayerController.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/5/24.
//

import Foundation
import UIKit

class InputManager: InputManagerProtocol{
    let OnDoPlayerAction: Event<PlayerAction> = Event<PlayerAction>()
    let encoder = JSONEncoder()
    
    public static let shared = InputManager()
    
    
    public func InputPointer(vector: CGVector){
        print("Input pointer")
        var action = PlayerAction(
            CharacterModelID: UUID(),
            ActionType: .UseSkill,
            Skill: .Move)
        action.content[.Impulse] = encodeJSON(vector)
        OnDoPlayerAction.Invoke(action)
    }
    private func encodeJSON(_ message: Codable)-> String{
        do{
            let jsonData = try encoder.encode(message)
            return String(data: jsonData, encoding: .utf8)!
        }catch{
            print(error)
        }
        return ""
    }
    
    
}
