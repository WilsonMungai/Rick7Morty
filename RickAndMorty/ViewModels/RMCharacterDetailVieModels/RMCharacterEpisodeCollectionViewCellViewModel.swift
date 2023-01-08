//
//  RMCharacterEpisodeCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Wilson Mungai on 2023-01-08.
//

import Foundation

final class RMCharacterEpisodeCollectionViewCellViewModel
{
    let episodeDataUrl: URL?
    
    init(episodeDataUrl: URL?)
    {
        self.episodeDataUrl = episodeDataUrl
    }
}
