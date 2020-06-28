//
//  TCPDataTransport.swift
//  SwiftLSPClient
//
//  Created by Manuel Gauto on 6/27/20.
//

import Foundation
import SwiftSocket

class TCPDataTransport: DataTransport {
    private var host: String
    private var port: Int
    private var socket: TCPClient
    private var readHandler: ReadHandler
    
    private var shouldRun: Bool
    
    public init(host: String, port: Int32) {
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
        self.readHandler = handler
    }

    func checkForData() {
        while self.shouldRun {
            let bytesAvailable = self.socket.bytesAvailable()
            if bytesAvailable != nil && bytesAvailable != 0 {
                let bytes = self.socket.read(Int(bytesAvailable!))
                if bytes != nil {
                    self.readHandler(Data(bytes!))
                }
            }
        }
    }
    
    func close() {
        self.shouldRun = false
        self.socket.close()
    }
}
