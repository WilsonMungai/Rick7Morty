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
    
    enum RMServiveError: Error
    {
        case failedToCreateRequest
        case failedToGetData
    }
    
    /// Send Rick and Morty API call
    /// - Parameters:
    ///   - request: Request instance
    ///   - completion: Callback with data or error
    ///   - type: The type of object we expect to get back
    public func execute<T: Codable>(
        _ request: RMRequest,
        expecting type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void )
    {
        guard let urlRequest = self.request(from: request)
        else
        {
            completion(.failure(RMServiveError.failedToCreateRequest))
            return
        }
        print("API Call: \(request.url?.absoluteString ?? "")")
        let task = URLSession.shared.dataTask(with: urlRequest) { data, __, error in
            guard let data = data, error == nil else{
                completion(.failure(error ?? RMServiveError.failedToGetData))
                return
            }
            
            // Decode response
            do
            {
                let result = try JSONDecoder().decode(type.self, from: data)
                completion(.success(result))
            }
            catch
            {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    // MARK: - Private
    
    private func request(from rmResquest: RMRequest)-> URLRequest?
    {
        guard let url = rmResquest.url else {return nil}
        
        var request = URLRequest(url: url)
        request.httpMethod = rmResquest.httpMethod
        
        return request
    }
}
