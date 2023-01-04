//
//  RMCharacterDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Wilson Mungai on 2023-01-01.
//

import Foundation

final class RMCharacterDetailViewViewModel
{
    private let character: RMCharacter
    
    // Passing the character
    init (character: RMCharacter)
    {
        self.character = character
    }
    
    private var requestUrl:URL?
    {
        return URL(string: character.url)
    }
    
    public var title: String
    {
        character.name.uppercased()
    }
}
