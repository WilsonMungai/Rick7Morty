//
//  RMEpisodeDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Wilson Mungai on 2023-01-18.
//

import UIKit

class RMEpisodeDetailViewViewModel {
    
    private let endpointUrl: URL?
    
    init(endpointUrl: URL?) {
        self.endpointUrl = endpointUrl
        fetcheEpisodeData()
    }
    
    private func fetcheEpisodeData() {
        guard let url = endpointUrl, let request = RMRequest(url: url) else {
            return
        }
        
        RMService.shared.execute(request,
                                 expecting: RMEpisodes.self) { result in
            switch result {
            case .success(let success):
                print(String(describing: success))
            case . failure:
                break
            }
        }
    }
}
