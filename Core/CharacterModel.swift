//
//  CharacterModel.swift
//  polypoly
//
//  Created by mac03 on 2023/5/22.
//

import Foundation
import SpriteKit

class CharacterModel: Ball{
    //--Variable--
    public var node: Ball
//    private var poly: DrawingLine
    internal var cmID: Int //CharacterModel ID
//    private position: CGPoint
    //------------
    
    //--Initial--
    init(ID: Int) {
        self.node = Ball()
        self.cmID = ID
        super.init()
        self.position = CGPoint(x: 0, y: 0)
        self.node.position = position
    }
    init(ID: Int, position: CGPoint) {
        
        self.node = Ball()
        self.node.position = position
        self.cmID = ID
        super.init()
        self.position = position
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //------------
//    
//    public func ReceivePlayerAction(){
//        
//    }
//    internal func DrawBeginAction(){
//        
//    }
//    internal func DrawMoveAction(){
//        
//    }
//    internal func DrawEndAction(){
//        
//    }
//    internal func MoveAction(){
//        
//    }
}
