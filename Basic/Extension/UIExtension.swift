//
//  UIExtension.swift
//  polypoly
//
//  Created by mac03 on 2023/6/12.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(grayscale: CGFloat){
        let gray = 255 * grayscale
        self.init(red: gray, green: gray, blue: gray, alpha: 1)
    }
}
