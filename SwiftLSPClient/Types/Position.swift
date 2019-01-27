//
//  Position.swift
//  SwiftLSPClient
//
//  Created by Matt Massicotte on 2019-01-16.
//  Copyright © 2019 Chime Systems. All rights reserved.
//

import Foundation

public struct Position {
    public let line: Int
    public let character: Int

    public init(line: Int, character: Int) {
        self.line = line
        self.character = character
    }
}

extension Position: CustomStringConvertible {
    public var description: String {
        return "{\(line), \(character)}"
    }
}

extension Position: Codable {
}

extension Position: Equatable {
}