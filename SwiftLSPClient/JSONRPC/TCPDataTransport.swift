//
//  TCPDataTransport.swift
//  SwiftLSPClient
//
//  Created by Manuel Gauto on 6/27/20.
//

import Foundation
import SwiftSocket

class TCPDataTransport: DataTransport {
    private host: String
    private port: Int
    private socket: TCPClient
    private readHandler: ReadHandler
    
    private shouldRun: Bool
    
    public init(host: String, port: Int) {
        self.host = host
        self.port = port
        
        self.shouldRun = true
        
        self.socket = TCPClient(address: host, port: port)
        
        DispatchQueue.global(qos: .background).async {
            self.checkForData()
        }
    }
    
    func write(_ data: Data) {
        socket.send(data: data)
    }
    
    func setReaderHandler(_ handler: @escaping ReadHandler) {
        self.readHandler = readHandler
    }

    func checkForData() {
        while self.shouldRun {
            let bytesAvailable = self.socket.bytesAvailable()
            if bytesAvailabl != nil && bytesAvailable() != 0 {
                self.readHandler(bytesAvailable)
            }
        }
    }
    
    func close() {
        self.shouldRun = false
        self.socket.close()
    }
}
