//
//  File.swift
//  
//
//  Created by Manuel Gauto on 11/11/19.
//

import Foundation

public class PocketIDEServerRequest: Codeable {
    let token: String
    let request: Data
    
    public init(token: String, request: Data) {
        self.token = token
        self.request = request
    }
}
