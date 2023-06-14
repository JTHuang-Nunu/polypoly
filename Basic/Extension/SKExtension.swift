//
//  SKExtension.swift
//  polypoly
//
//  Created by mac03 on 2023/6/12.
//

import Foundation
import SpriteKit

extension SKNode{
    func _update(_ currentTime: TimeInterval){
        NodeUpdate(currentTime)
        for child in children{
            child._update(currentTime)
        }
    }
    @objc public func NodeUpdate(_ currentTime: TimeInterval){
        
    }
}
extension SKShapeNode {
    func shadow() -> SKShapeNode{
        let shadow = self.copy() as! SKShapeNode
//        let offset = shadow.frame.size.height  * 0.03
        let offset:CGFloat = 5
        shadow.position = CGPoint(offset, -offset)

        shadow.fillColor = .gray
        shadow.strokeColor = .clear
        shadow.zPosition = -1
//        self.addChild(shadow)
        return shadow
    }
    func revertShadow() -> SKShapeNode{
        let shadow = self.copy() as! SKShapeNode
//        let offset = shadow.frame.size.height  * 0.03
        let offset:CGFloat = 5
        shadow.position = CGPoint(-offset, +offset)

        shadow.fillColor = .yellow
        shadow.strokeColor = .clear
        shadow.zPosition = -1
//        self.addChild(shadow)
        return shadow
    }
}

extension SKSpriteNode{
//    func scaleTo(ScreenWidthPercentage: CGFloat){
//        let aspectRatio = self.size.height / self.size.width
//        let ratio = ScreenWidthPercentage * aspectRatio
//        self.size.height =
//        self.size = CGSize(width: ScreenWidthPercentage, height: self.size.height * ratio)
//    }
    func fitOutScreen(){
        let screenRatio = ScreenSize.width / ScreenSize.height
        let selfRatio = self.size.width / self.size.height
        
        if(screenRatio > selfRatio){ // screen is wider
            self.size = CGSize(width: ScreenSize.width, height: ScreenSize.width / selfRatio)
        } else{
            self.size = CGSize(width: ScreenSize.height * selfRatio, height: ScreenSize.height)
        }
    }
    func fitInScreen(){
        let screenRatio = ScreenSize.width / ScreenSize.height
        let selfRatio = self.size.width / self.size.height
        
        if(screenRatio > selfRatio){ // screen is wider
            self.size = CGSize(width: self.size.width/screenRatio, height: ScreenSize.height)
        } else{
            self.size = CGSize(width: ScreenSize.width, height: ScreenSize.height / screenRatio)
        }
    }
    func fitScreen() -> CGSize?{
        let screenRatio = ScreenSize.width / ScreenSize.height
        let selfRatio = self.size.width / self.size.height
        
        if(screenRatio > selfRatio){ // screen is wider
            self.size = CGSize(width: ScreenSize.height*selfRatio, height: ScreenSize.height)
            return self.size
        } else{
//            self.size = CGSize(width: ScreenSize.width, height: ScreenSize.height / screenRatio)
        }
        return nil
    }
}
