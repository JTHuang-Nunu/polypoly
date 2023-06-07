//
//  parsecCGVector.swift
//  polypoly
//
//  Created by mac03 on 2023/6/3.
//

import CoreGraphics
import Foundation

class CGConverter {
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
    static func convertToCGVector(from string: String) -> CGVector? {
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
    
    static func convertToCGFloat(from string: String) -> CGFloat? {
        let decoder = JSONDecoder()
        do{
            let jsonData = string.data(using: .utf8)!
            let fVal = try decoder.decode(CGFloat.self, from: jsonData)
            return fVal
            
        }catch{
            print(error)
        }
        return nil
    
    }
}






