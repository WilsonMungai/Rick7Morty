//
//  RMCharacterCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Wilson Mungai on 2022-12-29.
//

import Foundation

final class RMCharacterCollectionViewCellViewModel: Hashable, Equatable
{
    // Properties to hold characters details to be displayed on the cell
    public let characterName: String
    private let characterStatus: RMCharacterStatus
    private let characterImageUrl: URL?
    
    // MARK: - Init
    init(
         characterName: String,
         characterStatus: RMCharacterStatus,
         characterImageUrl: URL?)
    {
        self.characterName = characterName
        self.characterStatus = characterStatus
        self.characterImageUrl = characterImageUrl
    }
    
    // Character properrty that holds the character's status alive/dead/unknown
    public var characterStatusText: String
    {
        return "Status: \(characterStatus.text)"
    }
    
    // Method to fetch the character image url
    public func fetchImage(completion: @escaping(Result<Data, Error>) -> Void)
    // TODO: Abstract to Image Manager
    {
        guard let url = characterImageUrl
        else
        {
            completion(.failure(URLError(.badURL)))
            
            return
        }
        // Fetches images
        RMImageLoader.shared.downLoadImage(url, completion: completion)
    }
    
    // MARK: - Hashable
    // Equatable to check whether two items are equal to one another
    static func ==(lhs: RMCharacterCollectionViewCellViewModel, rhs: RMCharacterCollectionViewCellViewModel) -> Bool
    {
        return lhs.hashValue == rhs.hashValue
    }
    // Create a unique hash value for the items every time the view model is created
    func hash(into hasher: inout Hasher)
    {
        hasher.combine(characterName)
        hasher.combine(characterStatus)
        hasher.combine(characterImageUrl)
    }
}

