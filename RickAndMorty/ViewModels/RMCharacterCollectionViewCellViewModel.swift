//
//  RMCharacterCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Wilson Mungai on 2022-12-29.
//

import Foundation

final class RMCharacterCollectionViewCellViewModel
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
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request)
        { data, _, error in
            guard let data = data, error == nil
            else
            {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            completion(.success(data))
        }
        task.resume()
        
    }
}
