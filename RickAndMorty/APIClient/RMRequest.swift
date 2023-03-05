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
    let endpoint: RMEndpoint
    
    /// Path components if any
    private let pathComponenets: [String]
    
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
    
    /// Attempt to create request
    /// Construct request
    /// - Parameters url: URL to parse
    /// - endpoint: Target endpoint
    /// - pathComponenets: Collection of path components
    /// - queryParameter: Collection of query components
    public init(endpoint: RMEndpoint,
                pathComponenets: [String] = [],
                queryParameter: [URLQueryItem] = [])
    {
        self.endpoint = endpoint
        self.pathComponenets = pathComponenets
        self.queryParameter = queryParameter
    }
    
    // Get url string and check whether it contains the constant url otherwise return nil
    convenience init?(url: URL)
    {
        let string = url.absoluteString
        
        if !string.contains(Constants.baseUrl)
        {
            return nil
        }
        
        // trim the string
        let trimmed = string.replacingOccurrences(of: Constants.baseUrl+"/", with: "")
        
        // parsing the trimmed url
        if trimmed.contains("/")
        {
            let components = trimmed.components(separatedBy: "/")
            if !components.isEmpty
            {
                let endPointString = components[0] // Initial endpoint, we use remove first when we have path components to avoid duplicating the value
                var pathComponents: [String] = []
                
                // We not only have the endpoints but we have a value in addition to the endpoint
                if components.count > 1
                {
                    pathComponents = components
                    //removes components[0]
                    pathComponents.removeFirst()
                }
                if let rmEndpoint = RMEndpoint(rawValue: endPointString)
                {
                    self.init(endpoint: rmEndpoint, pathComponenets:pathComponents )
                    return
                }
            }
        }
        else if trimmed.contains("?")
        {
            let components = trimmed.components(separatedBy: "?")
            if !components.isEmpty, components.count >= 2
            {
                let endPointString = components[0]
                let queryItemsString = components[1]
                let queryItems: [URLQueryItem]? = queryItemsString.components(separatedBy: "&").compactMap({
                    guard $0.contains("=")
                    else
                    {
                        fatalError("Unsupported Cell")
                    }
                    let parts  = $0.components(separatedBy: "=")
                    
                    return URLQueryItem(name:parts[0],
                                        value: parts[1])
                })
                if let rmEndpoint = RMEndpoint(rawValue: endPointString)
                {
                    self.init(endpoint: rmEndpoint, queryParameter: queryItems!)
                    return
                }
            }
        }
       return nil
    }
}

extension RMRequest
{
    static let listCharactersRequest = RMRequest(endpoint: .character)
    static let listEpisodesRequest = RMRequest(endpoint: .episode)
    static let listLocationsRequest = RMRequest(endpoint: .location)
}
