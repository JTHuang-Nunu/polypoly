//
//  Background.swift
//  polypoly
//
//  Created by mac03 on 2023/5/23.
//

import Foundation

import SpriteKit

class Background: SKSpriteNode {
    
    init(image: String) {
        let texture = SKTexture(imageNamed: image) // 设置背景纹理
        super.init(texture: texture, color: .clear, size: texture.size()) // 使用纹理创建父类的实例
        _setupoBody(position: CGPoint(x: 0, y: 0), rotate: .zero
        )
    }
    
    init(image: String, position: CGPoint, rotate: CGFloat) {
        let texture = SKTexture(imageNamed: image) // 设置背景纹理
        super.init(texture: texture, color: .clear, size: texture.size()) // 使用纹理创建父类的实例
        _setupoBody(position: position, rotate: rotate)
    }
    
    private func _setupoBody(position: CGPoint, rotate: CGFloat){
        self.zPosition = -1
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.position = position
        self.zRotation = rotate
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
