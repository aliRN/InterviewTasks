//
//  DayTimeView.swift
//  Sun
//
//  Created by Ali Rezaei on 3/30/24.
//

import SwiftUI

struct DayTimeView: View {
    
    var dayValue: CGFloat
    @Binding var showDayValue: Bool
    
    private let startRange: CGFloat = -.pi / 2
    private let endRange: CGFloat = 3 * .pi / 2
    private let amplitude: CGFloat = 50
    private let frequency: CGFloat = 1
    private let phaseShift: CGFloat = .pi
    
    private let dashLength: CGFloat = 10
    private let gapLength: CGFloat = 5
    
    @State private var dayAnimated: Bool = false
    @State private var trimEnd: CGFloat = 0
    
    @State private var progress: CGFloat = 0.1
    
    var body: some View {
        
        GeometryReader { geo in
            let path = getSinePath(width: geo.size.width)
            
            let trimmedPath = path.trimmedPath(from: 0, to: progress / 100)
            
            ZStack {
                path.trimmedPath(from: 0, to: 1)
                    .stroke(style: StrokeStyle(lineWidth: 3, dash: [dashLength, gapLength]))
                    .transformEffect(.init(translationX: geo.size.width / 4, y: 0))
                
                trimmedPath
                    .trim(from: 0, to: dayAnimated ? 1 : 0)
                    .stroke(Color.purple, lineWidth: 5)
                    .transformEffect(.init(translationX: geo.size.width / 4, y: 0))
                
                Image(systemName: "sun.max.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .foregroundColor(.yellow)
                    .position(x: 0, y: 0)
                    .offset(x: 100, y: 0)
                    .modifier(FollowEffect(pct: self.dayAnimated ? 1 : 0, path: trimmedPath))
            }
        }
        .onChange(of: showDayValue, { oldValue, newValue in
            withAnimation(.linear(duration: 2)) {
                progress = dayValue
                dayAnimated.toggle()
            }
        })
    }
    
    private func getSinePath(width: CGFloat) -> Path {
        Path { path in
            path.move(to: CGPoint(x: -width / 4, y: amplitude))
            let range = (endRange + startRange * -1) / 100 * 100 + startRange
            
            for angle in stride(from: startRange, through: endRange + 0.01, by: 0.01) {
                if angle > range {
                    break
                }
                let x = angle * frequency
                let y = amplitude * sin(x + phaseShift)
                path.addLine(to: CGPoint(x: CGFloat(angle) * width / (2 * .pi), y: y))
            }
        }
    }
}
