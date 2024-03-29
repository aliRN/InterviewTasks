//
//  Config.swift
//  ItemConfig
//
//  Created by Ali Rezaei on 3/29/24.
//

import SwiftUI

@Observable class Config: Codable {
    
    @ObservationIgnored var id: Int
    
    var options: [Option]
    
    var selectedOption: Int
    
    enum CodingKeys: CodingKey {
        case id
        case _options
        case _selectedOption
        case _$observationRegistrar
    }
    
    init(id _id: Int, options opts: [Option] = [
        Option(id: 0, state: false),
        Option(id: 1, state: false),
        Option(id: 2, state: false),
    ]) {
        id = _id
        options = opts
        selectedOption = 0
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self._options = try container.decode([Option].self, forKey: ._options)
        self._selectedOption = try container.decode(Int.self, forKey: ._selectedOption)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self._options, forKey: ._options)
        try container.encode(self._selectedOption, forKey: ._selectedOption)
        try container.encode(self._$observationRegistrar, forKey: ._$observationRegistrar)
    }
}

extension Config {
    
    func getOption(_ id: Int) -> Option {
        options.first { opt in
            opt.id == id
        }!
    }
    func setState(_ state: Bool) {
        if let idx = options.firstIndex (where: { opt in
            opt.id == selectedOption
        }) {
            let option = options[idx]
            option.state = state
            options[idx] = option
            saveConfig()
        }
    }
    func setSelectedOption(_ id: Int) {
        selectedOption = id
        saveConfig()
    }
    
    func saveConfig() {
        if let encoded = try? JSONEncoder().encode(self) {
            UserDefaults.standard.set(encoded, forKey: "ConfigData\(id)")
        }
    }
}
