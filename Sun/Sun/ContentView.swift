//
//  ContentView.swift
//  Sun
//
//  Created by Ali Rezaei on 3/30/24.
//

import SwiftUI

struct ContentView: View {
    @State private var showDayValue: Bool = false
    private var value: CGFloat = 70
    var body: some View {
        VStack {
            Spacer(minLength: 200)
            DayTimeView(dayValue: value, showDayValue: $showDayValue)
            Spacer()
            Button(action: {
                showDayValue.toggle()
            }, label: {
                Text("\(value.description)%")
            })
        }
        .padding(.vertical)
    }
}

#Preview {
    ContentView()
}
