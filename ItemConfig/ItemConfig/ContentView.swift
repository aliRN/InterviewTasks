//
//  ContentView.swift
//  ItemConfig
//
//  Created by Ali Rezaei on 3/29/24.
//

import SwiftUI

struct ContentView: View {
    
    var items: [Item] = [
        Item(id: 0),
        Item(id: 1),
        Item(id: 2)
    ]
    @State private var count: Int = 0
    
    var body: some View {
        List(items) { item in
            ItemView(item: item)
        }
        List(items) { item in
            let opt = item.config.getOption(item.config.selectedOption)
            Text("Item \(item.id) configs => option: \(opt.id) | toggle: \(opt.state)")
        }
    }
    
}

#Preview {
    ContentView()
}
