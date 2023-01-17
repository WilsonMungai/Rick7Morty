//
//  RMCharacterEpisodeCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Wilson Mungai on 2023-01-08.
//

import Foundation

// Creates a protocol of the RMEpidoes and then call it in the registerForData public func
protocol RMEpisodeDataRender {
    var name: String {get}
    var air_date: String {get}
    var episode: String {get}
}

final class RMCharacterEpisodeCollectionViewCellViewModel
{
    private var isFetching = false

    // Variable to hang on to the block in the registerForData function
    private var dataBlock: ((RMEpisodeDataRender) -> Void)?
    // Instance of RMEpisodes which is optional since we dont have the episodes
    private var episode: RMEpisodes? {
        didSet {
            guard let model = episode else {
                return
            }
            dataBlock?(model)
                    
        }
    }
    let episodeDataUrl: URL?
    
    // MARK: Public
    // We call the protocol RMEpisodeDataRender instead of calling the RMEpisode model so that we can only return the data in the defined in the protocol
    public func registerForData(_ block: @escaping (RMEpisodeDataRender) -> Void) {
        self.dataBlock = block
    }
    
    // MARK: Init
    init(episodeDataUrl: URL?)
    {
        self.episodeDataUrl = episodeDataUrl
    }
    
    // Fecthes the episode urls
    public func fetchEpisode() {
        guard !isFetching else {
            if let model = episode {
                dataBlock?(model)
            }
            return
        }
        
        guard let url = episodeDataUrl, let request = RMRequest(url: url) else {
            return
        }
        isFetching = true
        
        RMService.shared.execute(request,
                                 expecting: RMEpisodes.self) { [weak self] result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    self?.episode = model
                }
            case .failure(let failure):
                print(String(describing: failure))
            }
        }
    }
}
