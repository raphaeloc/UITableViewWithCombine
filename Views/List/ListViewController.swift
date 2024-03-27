//
//  ListViewController.swift
//  UITableViewWithCombine
//
//  Created by Rapha on 26/03/24.
//

import UIKit
import Combine

class ListViewController: UIViewController {
    
    // MARK: - Variables & Constants
    let viewModel = ViewModel()
    
    var cancellables = Set<AnyCancellable>()
    
    // MARK: - Initializers
    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    // MARK: - Deinitializer
    deinit {
        cancellables.forEach { $0.cancel() }
    }
    
    // MARK: - Life cycle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Task {
            await viewModel.fetch()
        }
    }
    
    // MARK: - Setup methods
    private func setup() {
        setupBinding()
    }
    
    private func setupBinding() {
        viewModel.$items
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                (self?.view as? ListView)?.reloadTable()
            }
            .store(in: &cancellables)
        
        viewModel.$viewState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] viewState in
                guard let `self` = self else {
                    return
                }
                handle(viewState)
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Binding methods
    func handle(_ viewState: ViewModel.ViewState) {
        switch viewState {
        case .data:
            guard !view.isKind(of: ListView.self) else { return }
            self.view = ListView(delegate: self.viewModel)
        case .loading:
            guard !view.isKind(of: LoadingView.self) else { return }
            self.view = LoadingView()
        case .error:
            guard !view.isKind(of: ErrorView.self) else { return }
            self.view = ErrorView(delegate: self.viewModel)
        }
    }
}
