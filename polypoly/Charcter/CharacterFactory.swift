//
//  Factory.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/5/26.
//

import Foundation
import SpriteKit

class CharacterFactory{
    func createCharacter(ID: UUID, position: CGPoint) -> Character{
        return Character(characterModelID: ID, position: position)
    }
    func createCharacter(ID: UUID) -> Character{
        return Character(characterModelID: ID)
    }
}
