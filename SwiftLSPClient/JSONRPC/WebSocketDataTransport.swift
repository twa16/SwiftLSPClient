//
// Created by Manuel Gauto on 11/11/19.
// Copyright (c) 2019 Chime Systems. All rights reserved.
//

import Foundation
import Starscream

public class WebSocketDataTransport: DataTransport, WebSocketDelegate {

    private let websocket: WebSocket

    private var dataHandler: WebSocketDataTransport.ReadHandler?
    
    public init(socketURL: URL) {
        //Setup our socket
        self.websocket = WebSocket(url: socketURL)
        self.websocket.delegate = self
        
        //Connect
        self.websocket.connect()

    }
    
    public func write(_ data: Data) {
        self.websocket.write(data: data)
    }

    public func setReaderHandler(_ handler: @escaping WebSocketDataTransport.ReadHandler) {
        self.dataHandler = handler
    }

    public func close() {
        self.websocket.disconnect()
    }

    public func websocketDidConnect(socket: WebSocketClient) {
        print("Connected to LSP Socket!")
        self.websocket.write(string: "Hi Server!")
    }

    public func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        
    }
    
    public func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        
    }
    
    public func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        self.dataHandler?(data)
    }
    
}
