//
//  RMCharacterStatus.swift
//  RickAndMorty
//
//  Created by Wilson Mungai on 2022-12-28.
//

import Foundation

enum RMCharacterStatus: String, Codable
{
    case alive = "Alive"
    case dead = "Dead"
    case `unknown` = "unknown"
    
    var text: String
    {
        switch self
        {
        case .alive,
             .dead:
            return rawValue
            
        case .unknown:
            return "Unkown"
        }
    }
}
