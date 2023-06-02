////
////  PlayerPosition.swift
////  polypoly
////
////  Created by mac03 on 2023/5/31.
////
//
import Foundation
import UIKit

// 玩家位置工廠介面
protocol PlayerPositionProtocol {
    func createPlayerPositions() -> [CGPoint]
}

// One player
class OnePlayerPosition: PlayerPositionProtocol {
    let midX = UIScreen.main.bounds.midX
    let midY = UIScreen.main.bounds.midY
    //  ||p1||
    func createPlayerPositions() -> [CGPoint] {
        let p1 = CGPoint(x: midX, y: midY)
        return [p1]
    }
}

// Two player
class TwoPlayerPosition: PlayerPositionProtocol {
    let midX = UIScreen.main.bounds.midX
    let midY = UIScreen.main.bounds.midY
    let offsetX: CGFloat = 200
    //  ||p1||p2||
    func createPlayerPositions() -> [CGPoint] {
        let p1 = CGPoint(x: midX - offsetX, y: midY)
        let p2 = CGPoint(x: midX + offsetX, y: midY)
        return [p1, p2]
    }
}

// Three player
class ThreePlayerPosition: PlayerPositionProtocol {
    let midX = UIScreen.main.bounds.midX
    let midY = UIScreen.main.bounds.midY
    let offsetX: CGFloat = 200
    let offsetY: CGFloat = 50
    //  ||  ||p1||  ||
    //  ||p2||  ||p3||
    func createPlayerPositions() -> [CGPoint] {
        let p1 = CGPoint(x: midX, y: midY + offsetY)
        let p2 = CGPoint(x: midX - offsetX, y: midY - offsetY)
        let p3 = CGPoint(x: midX + offsetX, y: midY - offsetY)
        return [p1, p2, p3]
    }
}

// Four player
class FourPlayerPosition: PlayerPositionProtocol {
    let midX = UIScreen.main.bounds.midX
    let midY = UIScreen.main.bounds.midY
    let offsetX: CGFloat = 200
    let offsetY: CGFloat = 50
    //  ||p1||p2||
    //  ||p3||p4||
    func createPlayerPositions() -> [CGPoint] {
        let p1 = CGPoint(x: midX - offsetX, y: midY + offsetY)
        let p2 = CGPoint(x: midX + offsetX, y: midY + offsetY)
        let p3 = CGPoint(x: midX - offsetX, y: midY - offsetY)
        let p4 = CGPoint(x: midX + offsetX, y: midY - offsetY)
        return [p1, p2, p3, p4]
    }
}

class PlayerPositionFactory {
    static func create(numberOfperson count: Int) -> PlayerPositionProtocol {
        switch count {
        case 1:
            return OnePlayerPosition()
        case 2:
            return TwoPlayerPosition()
        case 3:
            return ThreePlayerPosition()
        case 4:
            return FourPlayerPosition()
        default:
            fatalError("Unsupported player count")
        }
    }
}
