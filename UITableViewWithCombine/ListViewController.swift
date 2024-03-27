//
//  ListViewController.swift
//  UITableViewWithCombine
//
//  Created by Rapha on 26/03/24.
//

import UIKit
import Combine

class ListViewController: UIViewController {
    
    let viewModel = ViewModel()
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.fetch()
    }
    
    private func setup() {
        view.backgroundColor = .white
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
                
                switch viewState {
                case .data:
                    guard !view.isKind(of: ListView.self) else { return }
                    self.view = ListView(delegate: self.viewModel)
                case .loading:
                    guard !view.isKind(of: LoadingView.self) else { return }
                    self.view = LoadingView()
                case .noData:
                    self.view.backgroundColor = .red
                }
            }
            .store(in: &cancellables)
    }
}

