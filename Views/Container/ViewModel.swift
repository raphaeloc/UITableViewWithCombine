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
    
    
    // MARK: - Properties
    private(set) var items = [Item]()
    private let service = Service()
    
    // MARK: - Methods
    func fetch() {
        Task {
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
}
