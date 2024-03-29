//
//  Option.swift
//  ItemConfig
//
//  Created by Ali Rezaei on 3/29/24.
//

import SwiftUI

class Option: Codable {
    
    var id: Int
    var state: Bool
    
    enum CodingKeys: CodingKey {
        case id
        case state
    }
    
    init(id: Int, state: Bool) {
        self.id = id
        self.state = state
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.state = try container.decode(Bool.self, forKey: .state)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.state, forKey: .state)
    }
}
