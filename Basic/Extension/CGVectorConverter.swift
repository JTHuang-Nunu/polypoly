//
//  parsecCGVector.swift
//  polypoly
//
//  Created by mac03 on 2023/6/3.
//

import CoreGraphics
import Foundation

class CGVectorConverter {
    // 将 CGVector 转换为字符串
    static func convertToString(vector: CGVector) -> String {
        let encoder = JSONEncoder()
        do{
            let jsonData = try encoder.encode(vector)
            return String(data: jsonData, encoding: .utf8)!
        }catch{
            print(error)
        }
        return ""
    }
    
    // 将字符串转换回 CGVector
    static func convertToVector(from string: String) -> CGVector? {
        let decoder = JSONDecoder()
        do{
            let jsonData = string.data(using: .utf8)!
            let vector = try decoder.decode(CGVector.self, from: jsonData)
            return vector
            
        }catch{
            print(error)
        }
        return nil
    
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






