//
//  RMGetAllEpisodesResponse.swift
//  RickAndMorty
//
//  Created by Wilson Mungai on 2023-01-18.
//

import Foundation

struct RMGetAllEpisodesResponse: Codable
{
    struct Info: Codable
    {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
        
    }
    let info: Info
    let results: [RMEpisodes]
}
