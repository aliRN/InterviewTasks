//
//  Item.swift
//  SwiftItemConfig
//
//  Created by Ali Rezaei on 3/29/24.
//

import UIKit
import Combine

class Item {
    var id: Int
    
    var config: Config
        
    init(id: Int) {
        self.id = id
        config = Config(id: id)
        loadConfig()
    }
    
}

extension Item {
    private func loadConfig() {
        if let data = UserDefaults.standard.data(forKey: "ConfigData\(id)"),
           let conf = try? JSONDecoder().decode(Config.self, from: data) {
            config = conf
            config.configureCombine()
        }
    }
}
