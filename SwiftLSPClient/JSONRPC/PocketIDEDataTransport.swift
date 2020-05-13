//
//  PocketIDEDataTransport.swift
//  SwiftLSPClient
//
//  Created by Manuel Gauto on 5/12/20.
//

import Foundation
import Starscream

public class PocketIDEDataTransport: DataTransport, WebSocketDelegate {
    ///WebSocket transport. Should already be init'd by the client.
    private let websocket: WebSocket
    private var dataHandler: PocketIDEDataTransport.ReadHandler?
    private var isConnected = false
    
    public init(socket: WebSocket) {
        self.websocket = socket
        self.websocket.delegate = self
    }
    
    public func write(_ data: Data) {
        self.websocket.write(data: data)
    }
    
    public func setReaderHandler(_ handler: @escaping ReadHandler) {
        self.dataHandler = handler
    }
    
    public func close() {
        self.websocket.disconnect()
    }
    
    public func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
        case .connected(let headers):
            isConnected = true
            print("websocket is connected: \(headers)")
        case .disconnected(let reason, let code):
            isConnected = false
            print("websocket is disconnected: \(reason) with code: \(code)")
        case .text(let string):
            //print("Received text: \(string)")
            print("Received unknown text")
        case .binary(let data):
            self.dataHandler!(data)
        case .ping(_):
            break
        case .pong(_):
            break
        case .viabilityChanged(_):
            break
        case .reconnectSuggested(_):
            break
        case .cancelled:
            isConnected = false
        case .error(let error):
            isConnected = false
            print("Error with WebSocket: \(error?.localizedDescription ?? "Optional description is nil")")
        }
    }
    
    
}
