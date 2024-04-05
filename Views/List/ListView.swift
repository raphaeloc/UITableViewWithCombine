//
//  ListView.swift
//  UITableViewWithCombine
//
//  Created by Rapha on 26/03/24.
//

import UIKit

class ListView: UIView {
    
    // MARK: - Inner Protocols
    protocol DataDelegate: AnyObject {
        var numberOfRows: Int { get }
        func data(at index: Int) -> Item
    }

    // MARK: - Components
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    // MARK: - Properties
    weak var delegate: DataDelegate!
    
    // MARK: - Initializers
    init(delegate: DataDelegate) {
        self.delegate = delegate
        super.init(frame: .zero)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    // MARK: - Setup methods
    private func setup() {
        setupViews()
        setupConstraints()
    }
    private func setupViews() {
        backgroundColor = .white
        addSubview(tableView)
        tableView.register(
            TableViewCell.self,
            forCellReuseIdentifier: TableViewCell.identifier
        )
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate(
            [
                tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            ]
        )
    }
    
    // MARK: - Methods
    func reloadTable() {
        tableView.reloadData()
    }
}

// MARK: - TableView DataSource & Delegate
extension ListView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        delegate.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: TableViewCell.identifier,
            for: indexPath
        ) as? TableViewCell else {
            fatalError("The unique cell type should be kind of \(TableViewCell.identifier)")
        }
        
        cell.setup(item: delegate.data(at: indexPath.row))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        dump("ITEM -> \(delegate.data(at: indexPath.row))")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
}
