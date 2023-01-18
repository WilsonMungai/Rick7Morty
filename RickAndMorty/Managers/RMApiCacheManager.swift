//
//  RMApiCacheManager.swift
//  RickAndMorty
//
//  Created by Wilson Mungai on 2023-01-18.
//

import Foundation

/// Manages in memory session scoped Api caches
///  This class will help to hold an NSCache object so that before we make an API call, we first check whether the object is stored to avoid redundant calls by returning the cached object
final class RMApiCacheManager {
    // We are going to create cache of the api data that we are calling and the data that is returned
    // Dictionary
    // We are going to instantiate the caches according to the RMEndpoints
    // Compact map helps us to loop over all the cases and create and return an element
    private var cacheDictionary: [RMEndpoint: NSCache<NSString, NSData>] = [:]

    init() {
        setUpCache()
    }
    // MARK: - Public function
    // Function to check whether something is available inside the cache
    public func cachedResponse(for endpoint: RMEndpoint, url: URL?) -> Data? {
        guard let targetCache = cacheDictionary[endpoint], let url = url else {
            return nil
        }
        let key = url.absoluteString as NSString
        return targetCache.object(forKey: key) as? Data
    }
    
    // This function helps us to add something to the cache
    public func setCache(for endpoint: RMEndpoint, url: URL?, data: Data) {
        guard let targetCache = cacheDictionary[endpoint], let url = url else {
            return
        }
        let key = url.absoluteString as NSString
        targetCache.setObject(data as NSData, forKey: key)
    }
    
    // MARK: - Private function
    private func setUpCache() {
        RMEndpoint.allCases.forEach({ endpoint in
            cacheDictionary[endpoint] =  NSCache<NSString, NSData>()
        })
    }
}
