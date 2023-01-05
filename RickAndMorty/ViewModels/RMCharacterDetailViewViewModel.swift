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
    
    // enum section types to hold the different character detail information
    enum SectionType: CaseIterable
    {
        case photo
        case information
        case episodes
    }
    
    // MARK: - Init
    // A collection of values of SectionType
    public let sections = SectionType.allCases
    
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
