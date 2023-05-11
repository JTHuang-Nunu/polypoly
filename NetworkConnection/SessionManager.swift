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
        self.UDPConnection?.start(queue: .main)
        self.TCPConnection?.start(queue: .main)

            
    }
    
    
    
    
    public func sendData(message: String, reliable: Bool = false){
        print("send data")
        let content = message.data(using: .utf8)
        
        switch(reliable){
        case true:
            self.TCPConnection?.send(content: content, completion: .contentProcessed({ error in
                if let error = error {
                    print("Failed to send message: \(error)")
                } else {
                    print("Message sent successfully.")
                }
            }))
        case false:
            self.UDPConnection?.send(content: content, completion: .contentProcessed({ error in
                if let error = error {
                    print("Failed to send message: \(error)")
                } else {
                    print("Message sent successfully.")
                }
            }))
        }

    }
}
