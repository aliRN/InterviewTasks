//
//  ViewController.swift
//  SwiftItemConfig
//
//  Created by Ali Rezaei on 3/29/24.
//

import UIKit

class ViewController: UIViewController {

    
    private var items: [Item]! = [
        Item(id: 0),
        Item(id: 1),
        Item(id: 2)
    ]
    private var tableView: UITableView! = nil
    private var dataSource: UITableViewDiffableDataSource<Int, Int>! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        configure()
    }


}

extension ViewController {
    private func configure() {
        configureTableView()
        configureDataSource()
    }
    
    private func configureTableView() {
        tableView = UITableView(frame: view.bounds, style: .insetGrouped)
        tableView.register(ItemViewCell.self, forCellReuseIdentifier: "itemCell")
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(tableView)
    }
    
    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Int, Int>(tableView: tableView, cellProvider: { [unowned self] tableView, indexPath, itemIdentifier -> UITableViewCell? in
            
            let item = items[itemIdentifier]
            let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ItemViewCell
            cell.item = item
            
            return cell
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
        snapshot.appendSections([0])
        snapshot.appendItems([0, 1, 2], toSection: 0)
        
        dataSource.apply(snapshot, animatingDifferences: false)
        
    }
}
