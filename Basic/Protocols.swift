//
//  Protocols.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/6/2.
//

import Foundation
import SpriteKit

protocol CharacterProtocol {
    var CharacterModelID: UUID { get set }
    var lineList: [DrawingLine] { get set }
    var SKNode: SKNode { get }

    func DoAction(action: PlayerAction)
}

protocol InputManagerProtocol {
    var OnDoPlayerAction: Event<PlayerAction> {get }
}

protocol Oppositable {
    var opposite: Self { get }
}

