//
//  RMService.swift
//  RickAndMorty
//
//  Created by Wilson Mungai on 2022-12-27.
//

// Will be responsible for making API calls
import Foundation

/// Primary API service object to get Rick and Morty data
final class RMService
{
    // A singleton class that we can access throught the whole project
    /// Shared singleton instance
    static let shared = RMService()
    
    /// Privatized constructor
    private init(){}
    
    /// Send Rick and Morty API call
    /// - Parameters:
    ///   - request: Request instance
    ///   - completion: Callback with data or error
    public func execute(_ request:  RMRequest, completion: @escaping () -> Void ){}
}
