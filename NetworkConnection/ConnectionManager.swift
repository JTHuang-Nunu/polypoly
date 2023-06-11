//
//  SessionManager.swift
//  polypoly
//
//  Created by Cheng Pong Huang on 2023/5/12.
//

import Foundation
import Network

class ConnectionManager{
    public let OnReceiveData: Event<String> = Event<String>()
    
    public let OnConnectionReady: Event<Void> = Event<Void>()
    public let OnConnectionFailed: Event<String> = Event<String>()
    
    
    private let MaxPackageSize = 1024
    private var TCPConnection: NWConnection?
    convenience init(hostInfo: HostInfo){
        self.init(ip: NWEndpoint.Host(hostInfo.IP), port: NWEndpoint.Port(rawValue: UInt16(hostInfo.Port))!)
    }
    convenience init(ip: NWEndpoint.Host, port: NWEndpoint.Port, startInit: Bool = true){
        let host = NWEndpoint.hostPort(host: ip, port: port)
        self.init(host: host, startInit: startInit)
    }
    init(host: NWEndpoint, startInit: Bool = true){
        self.TCPConnection = NWConnection(to: host, using: .tcp)

        self.TCPConnection?.stateUpdateHandler = { newState in
            switch newState {
            case .ready:
                self.OnConnectionReady.Invoke(())
            case .failed(let error):
                self.OnConnectionFailed.Invoke(error.localizedDescription)
            default:
                break
            }
        }
        
        setReceiveDataHandler{ data in
            self.OnReceiveData.Invoke(data)
        }
        
        if startInit{
            self.start()
        }

            
    }
    public func start(){
        self.TCPConnection?.start(queue: .main)
    }
    public func Cancel(){
        self.TCPConnection?.cancel()
    }
    
    
    public func sendData(message: String, reliable: Bool = true){
        let content = message.data(using: .utf8)!
        self.sendData(message: content)
        
    }

    public func sendData(message: Data, reliable: Bool = true){
        let totalPackets = (message.count / MaxPackageSize) + 1
        sendHeader(totalPackets: totalPackets)
        
        for packetIndex in 0..<totalPackets {
            let range = packetIndex * MaxPackageSize..<min((packetIndex + 1) * MaxPackageSize, message.count)
            let packet = message.subdata(in: range)
            sendPackage(package: packet)
        
        }
    }
    
    private func sendHeader(totalPackets: Int){
        var totalPackets = UInt32(totalPackets)
        let data = Data(bytes: &totalPackets, count: 4)
        sendPackage(package: data)
    }

    
    private func sendPackage(package: Data){
        self.TCPConnection?.send(content: package, completion: .contentProcessed({ error in
            self.printError(error: error)
        }))
    }
    private func sendPackage(package: String){
        let content = package.data(using: .utf8)
        sendPackage(package: content!)
    }
        
    
    private func setReceiveDataHandler(completion: @escaping (String) -> Void){
        self.TCPConnection?.receive(minimumIncompleteLength: 1, maximumLength: 65536) { (data, _, _, error) in
            if let data = data, let message = String(data: data, encoding: .utf8) {
                completion(message)
                self.setReceiveDataHandler(completion: completion)
            } else if let error = error {
                print("Failed to receive TCP message: \(error)")
            }
            
        }
    }
    

    
    
    private func printError(error: NWError?){
        if let error = error {
            print("Failed to send message: \(error)")
        } else {

        }
    }
}
