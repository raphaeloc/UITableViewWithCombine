//
//  ListViewController.swift
//  UITableViewWithCombine
//
//  Created by Rapha on 05/04/24.
//

import UIKit

class ListViewController: UIViewController {
    
    let items: [Item]

    init(items: [Item]) {
        self.items = items
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup methods
    func setup() {
        view = ListView(delegate: self)
    }
}

// MARK: - ListView.DataDelegate
extension ListViewController: ListView.DataDelegate {
    var numberOfRows: Int {
        items.count
    }
    
    func data(at index: Int) -> Item {
        items[index]
    }
}
