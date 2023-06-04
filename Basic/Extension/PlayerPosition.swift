////
////  PlayerPosition.swift
////  polypoly
////
////  Created by mac03 on 2023/5/31.
////
//
import Foundation
import UIKit

protocol PlayerPositionProtocol {
    func createPlayerPositions() -> [CGPoint]
    func center () -> CGPoint
    func positionOffset(x offsetX: CGFloat, y offsetY: CGFloat) -> CGPoint
}
extension PlayerPositionProtocol {
    func center () -> CGPoint {
        return CGPoint(x: 0, y: 0)
    }
    func positionOffset(x offsetX: CGFloat, y offsetY: CGFloat) -> CGPoint {
        let center = center()
        return CGPoint(x: center.x + offsetX, y: center.y + offsetY)
    }
}
// One player
class OnePlayerPosition: PlayerPositionProtocol {
    //  ||p1||
    func createPlayerPositions() -> [CGPoint] {
        let p1 = center()
        return [p1]
    }
}

// Two player
class TwoPlayerPosition: PlayerPositionProtocol {
    let offsetX: CGFloat = 200
    //  ||p1||p2||
    func createPlayerPositions() -> [CGPoint] {
        let p1 = positionOffset(x: -offsetX, y: 0)
        let p2 = positionOffset(x: offsetX, y: 0)
        return [p1, p2]
    }
}

// Three player
class ThreePlayerPosition: PlayerPositionProtocol {
    let offsetX: CGFloat = 200
    let offsetY: CGFloat = 50
    //  ||  ||p1||  ||
    //  ||p2||  ||p3||
    func createPlayerPositions() -> [CGPoint] {
        let p1 = positionOffset(x: 0, y: offsetY)
        let p2 = positionOffset(x: -offsetX, y: -offsetY)
        let p3 = positionOffset(x: offsetX, y: -offsetY)
        return [p1, p2, p3]
    }
}

// Four player
class FourPlayerPosition: PlayerPositionProtocol {
    let offsetX: CGFloat = 200
    let offsetY: CGFloat = 50
    //  ||p1||p2||
    //  ||p3||p4||
    func createPlayerPositions() -> [CGPoint] {
        let p1 = positionOffset(x: -offsetX, y: +offsetY)
        let p2 = positionOffset(x: +offsetX, y: +offsetY)
        let p3 = positionOffset(x: -offsetX, y: -offsetY)
        let p4 = positionOffset(x: +offsetX, y: -offsetY)
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
