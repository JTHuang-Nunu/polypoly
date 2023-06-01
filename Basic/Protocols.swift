//
//  Protocols.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/6/2.
//

import Foundation

protocol CharacterProtocol {
    var CharacterModelID: UUID { get set }
    var lineList: [DrawingLine] { get set }

    func DoAction(action: PlayerAction)
}

protocol InputManagerProtocol {
    var OnDoPlayerAction: Event<PlayerAction> {get }
}
