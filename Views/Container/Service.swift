//
//  Service.swift
//  UITableViewWithCombine
//
//  Created by Rapha on 26/03/24.
//

import Foundation

class Service {
    enum FetchError: Error {
        case invalidJson
        case invalidUrl
    }
    
    func fetchItems() async -> Result<Data, FetchError> {
        try? await Task.sleep(nanoseconds: 5 * 1_000_000_000)
        
        guard let path = Bundle.main.path(forResource: "items", ofType: "json") else {
            return .failure(.invalidJson)
        }
        
        do {
            let url = URL(fileURLWithPath: path)
            let data = try Data(contentsOf: url)
            return .success(data)
        } catch {
            return .failure(.invalidUrl)
        }
    }
}
