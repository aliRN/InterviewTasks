//
//  ItemViewCell.swift
//  SwiftItemConfig
//
//  Created by Ali Rezaei on 3/29/24.
//

import UIKit

class ItemViewCell: UITableViewCell {
    var item: Item! = nil {
        didSet {
            guard let item = item else { return }
            title.text = "Item \(item.id) description \(item.id)"
            for option in item.config.options {
                segmentView.insertSegment(withTitle: option.id.description, at: option.id, animated: false)
                if option.id == item.config.selectedOption {
                    segmentView.selectedSegmentIndex = option.id
                    toggle.isOn = option.state
                }
            }
        }
    }
    
    private var title: UILabel! = nil
    private var segmentView: UISegmentedControl! = nil
    private var toggle: UISwitch! = nil
    
    private let paddingV: CGFloat = 15
    private let paddingH: CGFloat = 20
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        config()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // some cleaning
    }
}

extension ItemViewCell {
    private func config() {
        title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(title)
        
        segmentView = UISegmentedControl()
        segmentView.translatesAutoresizingMaskIntoConstraints = false
        
        segmentView.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        contentView.addSubview(segmentView)
        
        toggle = UISwitch()
        toggle.translatesAutoresizingMaskIntoConstraints = false
        toggle.addTarget(self, action: #selector(toggleChanged), for: .valueChanged)
        contentView.addSubview(toggle)
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: paddingV),
            title.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            
            segmentView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10),
            segmentView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            segmentView.bottomAnchor.constraint(equalTo: toggle.bottomAnchor),
            segmentView.trailingAnchor.constraint(equalTo: toggle.leadingAnchor, constant: -100),
            
            toggle.topAnchor.constraint(equalTo: segmentView.topAnchor),
            toggle.trailingAnchor.constraint(equalTo: trailingAnchor),
            toggle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -paddingV),
//            toggle.heightAnchor.constraint(equalToConstant: 44.0),
            toggle.widthAnchor.constraint(equalToConstant: 70.0)
        ])
    }
    
    @objc private func segmentChanged(sender: UISegmentedControl) {
        item.config.selectedOption = sender.selectedSegmentIndex
        toggle.isOn = item.config.getOption(item.config.selectedOption).state
    }
    
    @objc private func toggleChanged() {
        item.config.setState(toggle.isOn)
    }
}
