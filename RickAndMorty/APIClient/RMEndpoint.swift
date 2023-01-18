//
//  RMEndpoint.swift
//  RickAndMorty
//
//  Created by Wilson Mungai on 2022-12-27.
//

import Foundation

/// Represnts unique API endpoints
//  We make it hashable so that we can use it as the key in the dictionary in the RMAPICacheManager
//  we use caseIterable so that we loop through all the 3 endpoints
@frozen enum RMEndpoint: String, CaseIterable, Hashable
{
    /// end point to get caharacter information
    case character
    /// end point to get location information
    case location
    /// end point to get episode information
    case episode
}
