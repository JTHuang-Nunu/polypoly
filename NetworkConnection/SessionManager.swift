//
//  SessionManager.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/5/12.
//

import Foundation
import Network

class SesstionManager{
    private var UDPConnection: NWConnection?
    private var TCPConnection: NWConnection?
    private let jsonEncoder = JSONEncoder()
    
    init(host: NWEndpoint){
        self.UDPConnection = NWConnection(to: host, using: .udp)
        self.TCPConnection = NWConnection(to: host, using: .tcp)

        self.UDPConnection?.stateUpdateHandler = { newState in
            switch newState {
            case .ready:
                print("Connection established successfully.")
            case .failed(let error):
                print("Failed to establish connection: \(error.localizedDescription)")
            default:
                break
            }
        }
        self.TCPConnection?.stateUpdateHandler = { newState in
            switch newState {
            case .ready:
                print("Connection established successfully.")
            case .failed(let error):
                print("Failed to establish connection: \(error.localizedDescription)")
            default:
                break
            }
        }
        
        
        setReceiveDataHandler{ str in
            print("receive data:\(str)")
        }
        
        
        self.UDPConnection?.start(queue: .main)
        self.TCPConnection?.start(queue: .main)

            
    }
    
    
    public func sendObject<T: Codable>(object: T, reliable: Bool = false) {
        
        do {
            let jsonData = try jsonEncoder.encode(object)
            let jsonString = String(data: jsonData, encoding: .utf8)!
            sendData(message: jsonString, reliable: reliable)
        } catch {
            print("Failed to encode object: \(error)")
        }
    }

    
    public func sendData(message: String, reliable: Bool = false){
        print("send data")
        let content = message.data(using: .utf8)
        
        switch(reliable){
        case true:
            self.TCPConnection?.send(content: content, completion: .contentProcessed({ error in
                self.printError(error: error)
            }))
        case false:
            self.UDPConnection?.send(content: content, completion: .contentProcessed({ error in
                self.printError(error: error)
            }))
        }

    }
    
    private func setReceiveDataHandler(completion: @escaping (String) -> Void){
        self.TCPConnection?.receive(minimumIncompleteLength: 1, maximumLength: 65536) { (data, _, _, error) in
            if let data = data, let message = String(data: data, encoding: .utf8) {
                completion(message)
            } else if let error = error {
                print("Failed to receive TCP message: \(error)")
            }
            
        }
        
        self.UDPConnection?.receiveMessage(completion: { (data, _, _, error) in
            if let data = data, let message = String(data: data, encoding: .utf8) {
                completion(message)
            } else if let error = error {
                print("Failed to receive UDP message: \(error)")
            }
        })
    }
    

    
    
    private func printError(error: NWError?){
        if let error = error {
            print("Failed to send message: \(error)")
        } else {
            print("Message sent successfully.")
        }
    }
}
