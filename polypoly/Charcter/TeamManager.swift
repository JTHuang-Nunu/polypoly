//
//  TeamManager.swift
//  polypoly
//
//  Created by mac03 on 2023/6/11.
//

import Foundation
import SpriteKit

class TeamManager{
//    public let OnAddObject = Event<Void>()
    var objectContainer = [SKNode]()
    
    init(character: Character) {
        character.OnCreateObstacle += addObject
    }
    
    func addObject(node: SKNode){
        objectContainer.append(node)
    }
}
