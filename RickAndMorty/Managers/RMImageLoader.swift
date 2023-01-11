//
//  ImageLoader.swift
//  RickAndMorty
//
//  Created by Wilson Mungai on 2023-01-03.
//

import Foundation

final class RMImageLoader
{
    static let shared = RMImageLoader()
    
    // Handles getting rid of session in the cache incase memory is getting low
    private var imageDataCache = NSCache<NSString, NSData>()
    
    private init(){}
    
    /// Get image data with url
    /// - Parameters:
    ///  - url: Source url
    ///  - completion: Callback
    public func downLoadImage(_ url: URL, completion: @escaping (Result<Data, Error>) -> Void)
    {
        let key = url.absoluteString as NSString
        if let data = imageDataCache.object(forKey: key)
        {
            completion(.success(data as Data))
            return
        }
        
        let request = URLRequest(url:url)
        let task = URLSession.shared.dataTask(with: request)
        { [weak self] data, _, error in
            guard let data = data, error == nil
            else
            {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            
            let value = data as NSData
            self?.imageDataCache.setObject(value, forKey: key)
            completion(.success(data))
        }
        task.resume()
    }
}
