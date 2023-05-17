//
//  GameManager.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/5/17.
//

import Foundation

class GameManager{
    private var PlayerList:[UUID] = []
    static var shared: GameManager?
    
    init(){
        GameManager.shared = self
    }
    
    public func SetPlayers(players: [UUID]){
        PlayerList = players
    }
    
    public func GetPlayers() -> [UUID]{
        return PlayerList
    }
    
    
}
