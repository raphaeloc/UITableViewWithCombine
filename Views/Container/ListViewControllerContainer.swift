//
//  ListViewController.swift
//  UITableViewWithCombine
//
//  Created by Rapha on 26/03/24.
//2

import UIKit
import Combine

class ListViewControllerContainer: UIViewController {
    
    // MARK: - Properties
    let viewModel = ViewModel()
    
    var cancellables = Set<AnyCancellable>()
    
    // MARK: - Initializers
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    // MARK: - Deinitializer
    deinit {
        cancellables.forEach { $0.cancel() }
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        viewModel.fetch()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - Setup methods
    private func setup() {
        view.backgroundColor = .white
        setupBinding()
    }
    
    private func setupBinding() {
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
    private func handle(_ viewState: ViewModel.ViewState) {
        switch viewState {
        case .data:
            changeCurrentChildViewController(to: ListViewController(items: viewModel.items))
        case .loading:
            changeCurrentChildViewController(to: LoadingViewController())
        case .error:
            changeCurrentChildViewController(
                to: ErrorViewController(
                    tryAgainAction: { [weak self] in
                        self?.viewModel.fetch()
                    }
                )
            )
        }
    }
}
