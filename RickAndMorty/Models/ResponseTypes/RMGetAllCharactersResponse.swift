//
//  RMGetAllCharactersResponse.swift
//  RickAndMorty
//
//  Created by Wilson Mungai on 2022-12-28.
//

import Foundation

struct RMGetAllCharactersResponse: Codable
{
    struct Info: Codable
    {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
        
    }
    let info: Info
    let results: [RMCharacter]
}
