//
//  Character.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/5/24.
//

import Foundation

class Character: CharacterModel{
    var CharacterModelID: UUID
    var ball: Ball
    init(characterModelID: UUID, ball: Ball){
        self.CharacterModelID = characterModelID
        self.ball = ball
    }
    
    
    func DoAction(action: PlayerAction) {
        
    }
    
    
    
    
}
