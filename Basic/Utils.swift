//
//  Util.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/6/7.
//

import Foundation
let encoder = JSONEncoder()
let decoder = JSONDecoder()
public func encodeJSON(_ message: Codable)-> String{
    do{
        let jsonData = try encoder.encode(message)
        return String(data: jsonData, encoding: .utf8)!
    }catch{
        print(error)
    }
    return ""
}

public func decodeJSON<T: Codable>(_ type: T.Type, jsonString: String)->T?{
    do{
        let jsonData = jsonString.data(using: .utf8)!
        let message = try decoder.decode(T.self, from: jsonData)
        return message
    }catch{
        print(error)
    }
    return nil

}
