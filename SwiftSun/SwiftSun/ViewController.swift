//
//  ViewController.swift
//  SwiftSun
//
//  Created by Ali Rezaei on 3/28/24.
//

import UIKit

class ViewController: UIViewController {
    
    weak var animationDelegate: PRAnimation? = nil
    
    private var dayValue: CGFloat = 75.0
    
    private var button: UIButton! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }


}

extension ViewController {
    private func config() {
        
        view.backgroundColor = .white
        
        let v = DayTimeView(isMain: true)
        v.translatesAutoresizingMaskIntoConstraints = false
        
        let v2 = DayTimeView(isMain: false, dayValue: dayValue)
        animationDelegate = v2
        v2.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(v)
        view.addSubview(v2)
        
        NSLayoutConstraint.activate([
            v.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            v.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.bounds.width / 4),
            v.widthAnchor.constraint(equalTo: view.widthAnchor),
            v.heightAnchor.constraint(equalToConstant: 300),
            
            v2.centerYAnchor.constraint(equalTo: v.centerYAnchor),
            v2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.bounds.width / 4),
            v2.widthAnchor.constraint(equalTo: view.widthAnchor),
            v2.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        createButton()
    }
    
    private func createButton() {
        button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("\(dayValue.description)%", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -100),
            button.widthAnchor.constraint(equalToConstant: 100),
            button.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
       
    @objc
    private func buttonClicked() {
        animationDelegate?.startAnimation()
    }
                         
}

protocol PRAnimation: AnyObject {
    func startAnimation()
}
