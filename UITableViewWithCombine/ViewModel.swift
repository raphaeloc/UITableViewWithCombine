//
//  ViewModel.swift
//  UITableViewWithCombine
//
//  Created by Rapha on 26/03/24.
//

import Foundation
import Combine

class ViewModel {
    // MARK: - Inner enum
    enum ViewState {
        case data
        case loading
        case error
    }
    
    // MARK: - Publishers
    @Published private(set) var viewState = ViewState.loading
    @Published private(set) var items = [Item]()
    
    // MARK: - Methods
    func fetch() {
        viewState = .loading
        
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
            guard let path = Bundle.main.path(forResource: "items", ofType: "json") else {
                self.viewState = .error
                return
            }
            
            do {
                let url = URL(fileURLWithPath: path)
                let data = try Data(contentsOf: url)
                let object = try JSONDecoder().decode([Item].self, from: data)
                self.items = object
                self.viewState = .data
            } catch {
                self.viewState = .error
            }
        }
    }
}

// MARK: - ListView.DataDelegate
extension ViewModel: ListView.DataDelegate {
    var numberOfRows: Int {
        items.count
    }
    
    func data(at index: Int) -> Item {
        items[index]
    }
}

// MARK: - ErrorView.Delegate
extension ViewModel: ErrorView.Delegate {
    func didTapOnTryAgainButton() {
        fetch()
    }
}
