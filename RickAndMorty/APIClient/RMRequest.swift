//
//  RMRequests.swift
//  RickAndMorty
//
//  Created by Wilson Mungai on 2022-12-27.
//

// Defines a native type to build up requets instead of passing raw data
import Foundation

/// Object that represnts a single API call
final class RMRequest
{
    // We have to know the base url
    // We have to know the endpoints
    // We have to know the path components
    // We have to know the query paramters
    
    /// API Constants
    private struct Constants
    {
        static let baseUrl = "https://rickandmortyapi.com/api"
    }
    
    // Constructed url for the api request in string format
    /// Desired end point
    private let endpoint: RMEndpoint
    
    /// Path components if any
    private let pathComponenets: Set<String>
    
    /// Query components if any
    private let queryParameter: [URLQueryItem]
    
    /// Constructed url for the API request in string format
    private var urlString: String
    {
        var string = Constants.baseUrl
        string += "/"
        string += endpoint.rawValue
        
        if !pathComponenets.isEmpty
        {
            pathComponenets.forEach({
                string += "/\($0)"})
        }
        
        if !queryParameter.isEmpty
        {
            string += "?"
            // name=value&name=value
            let argumentString = queryParameter.compactMap({
                guard let value = $0.value else{return nil}
                return "\($0.name)=\(value)"
            }).joined(separator: "&")
            
            string += argumentString
        }
        
        return string
    }
    
    /// Computed and constructed API url
    public var url: URL?
    {
        return URL(string: urlString)
    }
    
    // http get method
    /// Desired htttp method
    public let httpMethod = "GET"
    
    /// Construct request
    /// - Parameters:
    /// - endpoint: Target endpoint
    /// - pathComponenets: Collection of path components
    /// - queryParameter: Collection of query components
    public init(endpoint: RMEndpoint,
                pathComponenets: Set<String> = [],
                queryParameter: [URLQueryItem] = [])
    {
        self.endpoint = endpoint
        self.pathComponenets = pathComponenets
        self.queryParameter = queryParameter
    }
}
