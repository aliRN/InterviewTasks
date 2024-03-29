//
//  Config.swift
//  SwiftItemConfig
//
//  Created by Ali Rezaei on 3/29/24.
//

import UIKit
import Combine


class Config: Codable {
    var id: Int
    
    @Published var options: [Option]
    
    @Published var selectedOption: Int
    
    private var cancellable: [AnyCancellable] = []
    
    enum CodingKeys: CodingKey {
        case id
        case options
        case selectedOption
    }
    
    init(id _id: Int, options opts: [Option] = [
        Option(id: 0, state: false),
        Option(id: 1, state: false),
        Option(id: 2, state: false),
    ]) {
        id = _id
        options = opts
        selectedOption = 0
        
        configureCombine()
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.options = try container.decode([Option].self, forKey: .options)
        self.selectedOption = try container.decode(Int.self, forKey: .selectedOption)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.options, forKey: .options)
        try container.encode(self.selectedOption, forKey: .selectedOption)
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
            var option = options[idx]
            option.state = state
            options[idx] = option
        }
    }
    func setSelectedOption(_ id: Int) {
        selectedOption = id
    }
    
    func saveConfig() {
        if let encoded = try? JSONEncoder().encode(self) {
            UserDefaults.standard.set(encoded, forKey: "ConfigData\(id)")
        }
    }
    
    
    
    func configureCombine() {
        cancellable.append(contentsOf: [
            $options
                .combineLatest($selectedOption)
                .receive(on: DispatchQueue.main)
                .sink(receiveValue: { [unowned self] output in
                    saveConfig()
                })
                ])
        
    }
}
