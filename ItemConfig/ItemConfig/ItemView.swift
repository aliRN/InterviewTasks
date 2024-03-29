//
//  ItemView.swift
//  ItemConfig
//
//  Created by Ali Rezaei on 3/29/24.
//

import SwiftUI

struct ItemView: View {
    var item: Item
        
    @State private var selectedOption: Int
    
    @State private var optionValue: Bool
    
    @State private var count: Int = 0
    
    init(item : Item) {
        self.item = item
        let option = item.config.getOption(item.config.selectedOption)
        selectedOption = item.config.selectedOption
        optionValue = option.state
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("item \(item.id) description \(item.id.description)")
                Spacer()
            }
            HStack {
                Picker("\(item.id)", selection: $selectedOption) {
                    
                    ForEach(item.config.options, id: \.id) { opt in
                        Text(opt.id.description)
                    }
                }
                .pickerStyle(.segmented)
                Toggle(isOn: $optionValue) {
                    Text("")
                }
            }
        }
        
        .onChange(of: selectedOption) {
            let option = item.config.getOption(selectedOption)
            optionValue = option.state
            item.config.setSelectedOption(option.id)
            
        }
        .onChange(of: optionValue) {
            item.config.setState(optionValue)
            
        }
    }
}

#Preview {
    
    ItemView(item: Item(id: 0))
}
