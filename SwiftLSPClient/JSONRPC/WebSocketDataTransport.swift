//
// Created by Manuel Gauto on 11/11/19.
// Copyright (c) 2019 Chime Systems. All rights reserved.
//

import Foundation
import Starscream

public class WebSocketDataTransport: DataTransport, WebSocketDelegate {

    private let websocket: WebSocket

    public init(socketURL: URL) {
        //Setup our socket
        self.websocket = WebSocket(url: socketURL)
        self.websocket.delegate = self
        
        //Connect
        self.websocket.connect()

        self.websocket.write(string: "Hi Server!")
    }
    
    public func write(_ data: Data) {
        self.websocket.write(data: data)
    }

    public func setReaderHandler(_ handler: @escaping WebSocketDataTransport.ReadHandler) {
    }

    public func close() {
        self.websocket.disconnect()
    }

    public func websocketDidConnect(socket: WebSocketClient) {
        print("Connected to LSP Socket!")
    }

    public func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        
    }
    
    public func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        
    }
    
    public func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        
    }
    
}
