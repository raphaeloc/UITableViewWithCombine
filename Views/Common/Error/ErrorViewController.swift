//
//  ErrorViewController.swift
//  UITableViewWithCombine
//
//  Created by Rapha on 05/04/24.
//

import UIKit

class ErrorViewController: UIViewController {
    
    let tryAgainAction: () -> Void

    // MARK: - Initializers
    init(tryAgainAction: @escaping () -> Void) {
        self.tryAgainAction = tryAgainAction
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup methods
    private func setup() {
        view = ErrorView(delegate: self)
    }
}

// MARK: - ErrorView.Delegate
extension ErrorViewController: ErrorView.Delegate {
    func didTapOnTryAgainButton()  {
        tryAgainAction()
    }
}
