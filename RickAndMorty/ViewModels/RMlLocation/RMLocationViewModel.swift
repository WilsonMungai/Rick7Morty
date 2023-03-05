//
//  File.swift
//  RickAndMorty
//
//  Created by Wilson Mungai on 2023-03-04.
//

import UIKit

// interface
protocol RMLocationViewModelDelegate: AnyObject {
    func didFetchInitialLocation()
}

final class RMLocationViewModel {
    // hold onto the delegate in a weak capacity
    weak var delegate: RMLocationViewModelDelegate?
    
    // Hold the locations
    private var location: [RMLocation] = [] {
        // loop over the locations
        didSet {
            for locations in location {
                let cellViewModel = RMLocationTableViewCellViewModel(location: locations)
                if !cellViewModels.contains(cellViewModel) {
                    cellViewModels.append(cellViewModel)
                }
                
            }
        }
    }
    
    // Location response info
    // contains next url for pagination
    // only this class has the authority to assign to it
    public private(set) var cellViewModels: [RMLocationTableViewCellViewModel] = []
    
    private var apiInfo: RMGetAllLocationsResponse.Info?
    
    init() {}
    
    // function to return the loaction selected
    public func location(at index: Int) -> RMLocation?  {
        // verify the number of items in the table
        guard index < location.count, index >= 0 else {
            return nil
        }
        return self.location[index]
    }
    
    // fethc the locations
    public func fetchLocations() {
        RMService.shared.execute(.listLocationsRequest,
                                 expecting: RMGetAllLocationsResponse.self) { [weak self] result in
            switch result {
            case .success(let model):
                self?.apiInfo = model.info
                self?.location = model.results
                DispatchQueue.main.async {
                    self?.delegate?.didFetchInitialLocation()
                }
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }
    
    private var hasMoreResult: Bool {
        return false
    }
}
