//
//  HealthManager.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/6/7.
//

import Foundation

class StatsManager{
    public let OnDied = Event<Character>()
    public static let shared = StatsManager()
    private var _characterMap: [UUID: Character]? = nil
    var charactersHealth = [UUID: Int]()          //list of Characters Healdth point
//    var MaxHealth: Int = 100
//    var Health: Int = 100
    
    init(){
        
    }
    
    func UpdateStats(action: PlayerStats) {
        let character = _characterMap![action.CharacterModelID]
        let content = action.content

        switch action.statsType {
        case .Health:
            let hpValue = decodeJSON(CGFloat.self, jsonString: content[.HealthPoint]!)!
            character!.hp = hpValue
        case .Energy:
            let powerValue = decodeJSON(CGFloat.self, jsonString: content[.Energy]!)!
            character!.power.update(currentPower: powerValue)
        case .All:
            
            let hpValue = decodeJSON(CGFloat.self, jsonString: content[.HealthPoint]!)!
            let powerValue = decodeJSON(CGFloat.self, jsonString: content[.Energy]!)!
            character!.hp = hpValue
            character!.power.update(currentPower: powerValue)
        }
    }
    
    func CheckHealth(action: PlayerStats){
        let character = _characterMap![action.CharacterModelID]
        let content = action.content
        switch action.statsType {
        case .Health, .All:
            let hpValue = decodeJSON(CGFloat.self, jsonString: content[.HealthPoint]!)!
            if(hpValue <= 0){
                GameResult(loser: character!.CharacterModelID)
            }
        case .Energy:
            break
        }
    }
    func GameResult(loser: UUID){
        var map  = _characterMap
        map?.removeValue(forKey: loser)
        for(key, _) in map! {
//            print("\(key) is winner")
        }
    }
    public func SetCharacterMap(map: [UUID: Character]) {
        _characterMap = map
    }
    
//    public var IsDead: Bool{
//        get{
//            Health == 0
//        }
//    }
//
//    public func TakeDamage(who: Character, damage: Int){
//        Health -= damage
//    }
    
    
}
