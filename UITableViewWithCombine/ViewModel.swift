//
//  ViewModel.swift
//  UITableViewWithCombine
//
//  Created by Rapha on 26/03/24.
//

import Foundation
import Combine

class ViewModel {
    enum ViewState {
        case data
        case loading
        case noData
    }
    
    @Published private(set) var viewState = ViewState.loading
    @Published private(set) var items = [Item]()
    
    var numberOfRows: Int {
        items.count
    }
    
    func item(at index: Int) -> Item {
        items[index]
    }
    
    func fetch() {
        viewState = .loading
        
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
            self.items = [
                Item(icon: "message.fill", title: "Messages", description: "Chat with friends"),
                Item(icon: "person.fill", title: "Profile", description: "View your profile"),
                Item(icon: "gearshape.fill", title: "Settings", description: "Customize your preferences"),
                Item(icon: "paperplane.fill", title: "Send", description: "Send messages"),
                Item(icon: "bell.fill", title: "Notifications", description: "Manage your notifications"),
                Item(icon: "house.fill", title: "Home", description: "Go back to the home page")
            ]
            
            self.viewState = .data
        }
    }
}
