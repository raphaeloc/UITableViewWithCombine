//
//  LoadingViewController.swift
//  UITableViewWithCombine
//
//  Created by Rapha on 05/04/24.
//

import UIKit

class LoadingViewController: UIViewController {

    // MARK: - Initializers
    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup methods
    private func setup() {
        view = LoadingView()
    }
}
