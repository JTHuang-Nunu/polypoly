//
//  CoreProtocal.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/5/15.
//

import Foundation

enum ActionType{
    case ChooseAbility
    case UseAbility
}


protocol PlayerAction: Codable{
    var PlayerID: UUID {get set}
    var ActionType: ActionType {get set}
    var AbilityID: Int {get set}
    
}

    
