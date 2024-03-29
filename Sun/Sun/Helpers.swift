//
//  Helpers.swift
//  Sun
//
//  Created by Ali Rezaei on 3/30/24.
//

import SwiftUI

struct FollowEffect: GeometryEffect {
    var pct: CGFloat = 0
    let path: Path
    
    var animatableData: CGFloat {
        get { return pct }
        set { pct = newValue }
    }
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        
        let pt = percentPoint(pct)
        
        return ProjectionTransform(CGAffineTransform(translationX: pt.x, y: pt.y))
        
    }
    func percentPoint(_ percent: CGFloat) -> CGPoint {
        
        let pct = percent > 1 ? 0 : (percent < 0 ? 1 : percent)
        
        let f = pct > 0.999 ? CGFloat(1-0.001) : pct
        let t = pct > 0.999 ? CGFloat(1) : pct + 0.001
        let tp = path.trimmedPath(from: f, to: t)
        
        return CGPoint(x: tp.boundingRect.midX, y: tp.boundingRect.midY)
    }
}
