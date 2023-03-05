//
//  RMGetLocationsResponse.swift
//  RickAndMorty
//
//  Created by Wilson Mungai on 2023-03-04.
//

import Foundation

struct RMGetAllLocationsResponse: Codable
{
    struct Info: Codable
    {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
        
    }
    let info: Info
    let results: [RMLocation]
}
