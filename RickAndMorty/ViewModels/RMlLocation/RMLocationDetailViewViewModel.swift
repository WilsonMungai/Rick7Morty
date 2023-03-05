//
//  RMLocationDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Wilson Mungai on 2023-03-05.
//

import UIKit

protocol RMLocationDetailViewViewModelDelegate: AnyObject {
    func  didFetchLocationDtaials()
}

final class RMLocationDetailViewViewModel {
    
    private let endpointUrl: URL?
    
    private var dataTuple: (location: RMLocation, characters: [RMCharacter])? {
        // Notify the view to update
        didSet {
            createCellViewModels()
            delegate?.didFetchLocationDtaials()
        }
    }
    
    enum SectionType {
        case information(viewModel: [RMEpisodeInfoCollectionViewCellViewModel])
        case characters(viewModel: [RMCharacterCollectionViewCellViewModel])
    }
    
    public weak var delegate: RMLocationDetailViewViewModelDelegate?
    
    public private(set) var cellViewModels: [SectionType] = []
    
    // MARK: -Init
    init(endpointUrl: URL?) {
        self.endpointUrl = endpointUrl
        fetchLocationData()
    }
    
    // get characters
    public func character(at index: Int) -> RMCharacter? {
        guard let dataTuple  = dataTuple else {
            return nil
        }
        return dataTuple.characters[index]
    }
    
    // MARK: - Private Functions
    private func createCellViewModels() {
        guard let dataTuple = dataTuple else {
            return
        }
        let location = dataTuple.location
        let characters = dataTuple.characters
        
        var createdString = location.created
        if let date = RMCharacterInfoCollectionViewCellViewModel.dateFormatter.date(from: location.created)  {
            createdString = RMCharacterInfoCollectionViewCellViewModel.shortDateFormatter.string(from: date)
        }
        
        cellViewModels = [
            .information(viewModel: [
                .init(title: "Location Name", value: location.name),
                .init(title: "Type", value: location.type),
                .init(title: "Dimension", value: location.dimension),
                .init(title: "Created", value: createdString)
            ]),
            .characters(viewModel: characters.compactMap({ character in
                return RMCharacterCollectionViewCellViewModel(characterName: character.name, // $0 reperesents the character character.name
                                                              characterStatus: character.status,
                                                              characterImageUrl: URL(string: character.image))
            }))
        ]
    }
    /// Fetch backing location model
    public func fetchLocationData() {
        guard let url = endpointUrl, let request = RMRequest(url: url) else {
            return
        }
        
        RMService.shared.execute(request,
                                 expecting: RMLocation.self) { [weak self] result in
            switch result {
            case .success(let model):
                print(String(describing: model))
                // Call the function to fetch the related  characters and parse in the model which is the success
                self?.fetchRelatedCharacters(location: model)
            case . failure:
                break
            }
        }
    }
    
    private func fetchRelatedCharacters(location: RMLocation) {
        // This is going to give us a collection of url objects
        // This then loops to the second part where it tries to create a collection of requests from those Urls
        let requests: [RMRequest] = location.residents.compactMap({
            return URL(string: $0)
        }).compactMap({
            return RMRequest(url: $0)
        })
        
        // Dispacth group allows us to kick off n number of parallel requests and then notifies us when its all done
        let group = DispatchGroup()
        var characters: [RMCharacter] = []
        // Loop over the requests
        for request in requests {
            // This notifies that the request has started
            group.enter()
            RMService.shared.execute(request, expecting: RMCharacter.self) { result in
                // Defer is what will be called last before leaving the closure
                //In theory whatever count we get from group.enter() +=10, group.leave will -=10, notifying that we the loop has reached the end therefore leave
                defer {
                    group.leave()
                }
                // Completion handlers loops over the results
                switch result {
                case .success(let model):
                    // Adds the characters got to the model
                    characters.append(model)
                case.failure:
                    break
                }
            }
        }
        group.notify(queue: .main) {
            self.dataTuple = (
                location: location,
                characters: characters)
        }
    }
}
