//
//  RMCharacterPhotoCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Wilson Mungai on 2023-01-08.
//

import Foundation

final class RMCharacterPhotoCollectionViewCellViewModel
{
    private let imageUrl: URL?
    
    init(imageUrl: URL?)
    {
        self.imageUrl = imageUrl
    }
    
    public func fetchImage(completion: @escaping(Result<Data, Error>)-> Void)
    {
        guard let imageUrl = imageUrl else{
            completion(.failure(URLError(.badURL)))
            return 
        }
        RMImageLoader.shared.downLoadImage(imageUrl, completion: completion)
    }
}

