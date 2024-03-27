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
    
    // MARK: - Variables & Constants
    let service = Service()
    
    // MARK: - Methods
    func fetch() async {
        viewState = .loading
        
        let result = await service.fetchItems()
        switch result {
        case .success(let data):
            do {
                let object = try JSONDecoder().decode([Item].self, from: data)
                self.items = object
                self.viewState = .data
            } catch {
                self.viewState = .error
            }
        case .failure(let failure):
            dump("ERROR ON FETCH: \(failure)")
            self.viewState = .error
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
    func didTapOnTryAgainButton()  {
        Task {
            await fetch()
        }
    }
}
