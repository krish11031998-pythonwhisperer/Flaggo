//
//  NetworkError.swift
//  Flaggo
//
//  Created by Krishna Venkatramani on 2025-07-24.
//

import Foundation

enum NetworkError: LocalizedError, Error {
    case corruptedData
    case failedToFetch
    case badUrl
    case badResponse
    case noData
    
    var localizedDescription: String {
        switch self {
        case .corruptedData:
            return "Corrupted data received from the server."
        case .failedToFetch:
            return "Failed to fetch data from the server."
        case .badUrl:
            return "Invalid URL provided."
        case .noData:
            return "No data received from the server."
        case .badResponse:
            return "Bad response received from the server."
        }
    }
}
