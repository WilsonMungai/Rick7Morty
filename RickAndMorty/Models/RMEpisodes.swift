//
//  RMEpisodes.swift
//  RickAndMorty
//
//  Created by Wilson Mungai on 2022-12-27.
//

import Foundation

struct RMEpisodes: Codable
{
   let id: Int
   let name: String
   let air_date: String
   let episode: String
   let characters: [String]
   let url: String
   let created: String
}
