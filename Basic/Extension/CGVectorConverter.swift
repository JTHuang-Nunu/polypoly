//
//  parsecCGVector.swift
//  polypoly
//
//  Created by mac03 on 2023/6/3.
//

import CoreGraphics

class CGVectorConverter {
    // 将 CGVector 转换为字符串
    static func convertToString(vector: CGVector) -> String {
           return "\(vector)"
       }
    
    // 将字符串转换回 CGVector
    static func convertToVector(from string: String) -> CGVector? {
        let cleanedString = string.replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "")
        let components = cleanedString.components(separatedBy: ",")
        
        guard components.count == 2,
              let dx = Double(components[0]),
              let dy = Double(components[1].trimmingCharacters(in: .whitespaces)) else {
            return nil
        }
        
        return CGVector(dx: CGFloat(dx), dy: CGFloat(dy))
    }
}

//Using example
/*
let vector = CGVector(dx: 3.0, dy: 5.0)

// 将 CGVector 转换为字符串
let vectorString = CGVectorConverter.convertToString(vector: vector)
print(vectorString)

// 将字符串转换回 CGVector
if let parsedVector = CGVectorConverter.convertToVector(from: vectorString) {
    print(parsedVector)
} else {
    print("Can't parse to CGVector")
}
*/






