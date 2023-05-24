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
    convenience init(ip: NWEndpoint.Host, port: NWEndpoint.Port, startInit: Bool = true){
        let host = NWEndpoint.hostPort(host: ip, port: port)
        self.init(host: host, startInit: startInit)
    }
    init(host: NWEndpoint, startInit: Bool = true){
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
        
        if startInit{
            self.start()
        }

            
    }
    public func start(){
        self.UDPConnection?.start(queue: .main)
        self.TCPConnection?.start(queue: .main)
    }
    public func stop(){
        self.UDPConnection?.cancel()
        self.TCPConnection?.cancel()
    }
    public func sendData(message: Data, reliable: Bool = true){
        
        switch(reliable){
        case true:
            self.TCPConnection?.send(content: message, completion: .contentProcessed({ error in
                self.printError(error: error)
            }))
        case false:
            self.UDPConnection?.send(content: message, completion: .contentProcessed({ error in
                self.printError(error: error)
            }))
        }
    }
    
    public func sendData(message: String, reliable: Bool = true){
        let content = message.data(using: .utf8)
        self.sendData(message: content!, reliable: reliable)

    }
    
    public func setReceiveDataHandler(completion: @escaping (String) -> Void){
        self.TCPConnection?.receive(minimumIncompleteLength: 1, maximumLength: 65536) { (data, _, _, error) in
            if let data = data, let message = String(data: data, encoding: .utf8) {
                completion(message)
                self.setReceiveDataHandler(completion: completion)
            } else if let error = error {
                print("Failed to receive TCP message: \(error)")
            }
            
        }
        
        self.UDPConnection?.receiveMessage(completion: { (data, _, _, error) in
            if let data = data, let message = String(data: data, encoding: .utf8) {
                completion(message)
                self.setReceiveDataHandler(completion: completion)
            } else if let error = error {
                print("Failed to receive UDP message: \(error)")
            }
        })
    }
    

    
    
    private func printError(error: NWError?){
        if let error = error {
            print("Failed to send message: \(error)")
        } else {

        }
    }
}
