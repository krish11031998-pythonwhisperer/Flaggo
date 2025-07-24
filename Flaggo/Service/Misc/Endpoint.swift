//
//  Endpoint.swift
//  Flaggo
//
//  Created by Krishna Venkatramani on 22/07/2025.
//

import Foundation
import Combine

public protocol Endpoint {
    var host: String { get }
    var path: String { get }
    var urlScheme: String { get }
    var url: URL? { get }
    var queryItems: [URLQueryItem] { get }
    var urlCachePolicy: URLRequest.CachePolicy { get }
}

public extension Endpoint {
    
    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = urlScheme
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = queryItems
        return urlComponents.url
    }
    
    private var urlRequest: URLRequest? {
        guard let url else { return nil }
        var request = URLRequest(url: url)
        request.cachePolicy = urlCachePolicy
        return request
    }
    
    func fetchRequest<T: Decodable>() async throws -> T {
        guard let urlRequest else {
            throw URLError(.badURL)
        }
        
        print("(DEBUG) url: ", urlRequest.url?.absoluteURL)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
}
