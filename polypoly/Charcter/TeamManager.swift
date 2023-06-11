//
//  TeamManager.swift
//  polypoly
//
//  Created by mac03 on 2023/6/11.
//

import Foundation
import SpriteKit

class TeamManager{
    var objectContainer = [SKNode]()

    init(character: Character){
        character.OnCreateObstacle += addObject
    }
    
    func addObject(node: SKNode){
        objectContainer.append(node)
    }
    func removeObject(node: SKNode) {
            if let index = objectContainer.firstIndex(where: { $0 === node }) {
                objectContainer.remove(at: index)
            }
        }
}
