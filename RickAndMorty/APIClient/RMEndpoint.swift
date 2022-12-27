//
//  RMEndpoint.swift
//  RickAndMorty
//
//  Created by Wilson Mungai on 2022-12-27.
//

import Foundation

/// Represnts unique API endpoints
@frozen enum RMEndpoint: String
{
    /// end point to get caharacter information
    case character
    /// end point to get location information
    case location
    /// end point to get episode information
    case episode
}
