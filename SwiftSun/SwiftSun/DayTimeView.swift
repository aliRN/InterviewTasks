//
//  DayTimeView.swift
//  SwiftSun
//
//  Created by Ali Rezaei on 3/28/24.
//

import UIKit

class DayTimeView: UIView {
        
    
    var dayValue: CGFloat
    var isMain: Bool
    
    private let amplitude: CGFloat = 40.0
    private let frequency: CGFloat = 1.0
    private let phaseShift: CGFloat = .pi
    private let startRange: CGFloat = -.pi / 2
    private let endRange: CGFloat = 3 * .pi / 2
    private var progress: CGFloat = 100
    private let dashLength: NSNumber = 10
    private let gapLength: NSNumber = 5
    private let duration: CGFloat = 2
    private let xShift: CGFloat = -UIScreen.main.bounds.width / 4
    
    private var sunImage: UIImageView! = nil
    private var sunWave: CAShapeLayer! = nil
    private var animation: CAKeyframeAnimation! = nil
    
    init(isMain ism: Bool, dayValue dv: CGFloat = 0) {
        dayValue = dv
        isMain = ism
        if !isMain {
            progress = 0.1
        }
        
        super.init(frame: .zero)
        config()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension DayTimeView {
    private func config() {
        
        let lr = CAShapeLayer()
        lr.path = getSineLinePath()
        lr.fillColor = nil
        lr.lineWidth = 3
        lr.lineCap = .round
        layer.addSublayer(lr)
        
        if isMain {
            lr.lineDashPattern = [dashLength, gapLength]
            lr.strokeColor = UIColor.black.cgColor
        } else {
            lr.strokeColor = UIColor.purple.cgColor
            sunWave = lr
            createSun()
        }

    }
    
    private func getSineLinePath() -> CGPath {
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: xShift, y: amplitude))
        let range = (endRange + startRange * -1) / 100 * progress + startRange
        for angle in stride(from: startRange, through: endRange + 0.01, by: 0.01) {
            if angle > range {
                break
            }
            let x = angle * frequency
            let y = amplitude * sin(x + phaseShift)
            path.addLine(to: CGPoint(x: CGFloat(angle) * UIScreen.main.bounds.width / (2 * .pi), y: y))
        }
        
        return path.cgPath
    }
    
    private func createSun() {
        let imageView = UIImageView(image: UIImage(systemName: "sun.max.fill"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemYellow
        sunImage = imageView
        
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: amplitude - 15),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: xShift - 15),
            imageView.widthAnchor.constraint(equalToConstant: 30.0),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        ])
    }
    
    private func animateLine() {
        sunWave.path = getSineLinePath()
        
        let animate = CABasicAnimation(keyPath: "strokeEnd")
        animate.fromValue = 0
        animate.toValue = 1
        animate.duration = duration
        
        sunWave.add(animate, forKey: "linePath")
    }
    
    private func animateSun() {
        
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = getSineLinePath()
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.delegate = self
        animation.calculationMode = .paced
        
        sunImage.layer.add(animation, forKey: "imagePos")
    }
}

extension DayTimeView: PRAnimation {
    func startAnimation() {
        progress = dayValue
        animateLine()
        animateSun()
    }
}

extension DayTimeView: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            if let path = anim as? CAKeyframeAnimation,
               let endPoint = path.path?.currentPoint {
                sunImage.center = endPoint
            }
            
            sunImage.layer.removeAnimation(forKey: "imagePos")
            sunWave.removeAnimation(forKey: "linePath")
        }
    }
}
