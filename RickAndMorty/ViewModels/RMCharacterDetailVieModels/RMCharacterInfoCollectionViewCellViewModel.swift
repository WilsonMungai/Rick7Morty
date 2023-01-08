//
//  RMCharacterInfoCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Wilson Mungai on 2023-01-08.
//

import Foundation

final class RMCharacterInfoCollectionViewCellViewModel
{
    public let value: String
    public let title: String
    
    init(value: String, title: String)
    {
        self.value = value
        self.title = title
    }
}
