//
//  RestCountryEndpoint.swift
//  Flaggo
//
//  Created by Krishna Venkatramani on 22/07/2025.
//

import Foundation

 enum RestCountryEndpoint: Endpoint {    
    case all([Field])
    case countryDetails(String, [Field])
    case countryAllDetails(String)
    
     var urlScheme: String {
        "https"
    }
    
     var host: String {
        "restcountries.com"
    }
    
     var path: String {
        switch self {
        case .all:
            return "/v3.1/all"
        case .countryDetails(let country, _):
            return "/v3.1/name/\(country)"
        case .countryAllDetails(let country):
            return "/v3.1/name/\(country)"
        }
    }
    
     var queryItems: [URLQueryItem] {
        switch self {
        case .all(let fields):
            return [.init(name: "fields", value: fields.reduce("", { $0.isEmpty ? $1.rawValue : "\($0),\($1.rawValue)" }))]
        case .countryDetails(_, let fields):
            return [.init(name: "fields", value: fields.reduce("", { $0.isEmpty ? $1.rawValue : "\($0),\($1.rawValue)" }))]
        case .countryAllDetails:
            return [.init(name: "fullText", value: "true")]
        }
    }
    
     var urlCachePolicy: URLRequest.CachePolicy {
        .useProtocolCachePolicy
    }
}


