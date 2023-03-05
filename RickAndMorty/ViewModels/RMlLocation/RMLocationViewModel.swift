//
//  File.swift
//  RickAndMorty
//
//  Created by Wilson Mungai on 2023-03-04.
//

import UIKit

final class RMLocationViewModel {
    init() {}
    
    // Hold the locations
    private var location: [RMLocation] = []
    
    // Location response info
    // contains next url for pagination
    private var cellViewModels: [String] = []
    
    // fethc the locations
    public func fetchLocations() {
        RMService.shared.execute(.listLocationsRequest, expecting: String.self) { result in
            switch result {
            case .success(let success):
                break
            case .failure(let failure):
                break
            }
        }
    }
    
    private var hasMoreResult: Bool {
        return false
    }
}
