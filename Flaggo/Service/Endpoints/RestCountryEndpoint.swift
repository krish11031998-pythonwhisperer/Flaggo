//
//  RestCountryEndpoint.swift
//  Flaggo
//
//  Created by Krishna Venkatramani on 22/07/2025.
//

import Foundation

public enum RestCountryEndpoint: Endpoint {
    
    public enum Field: String {
        case alpha2Code
        case alpha3Code
        case altSpellings
        case area
        case borders
        case callingCodes
        case capital
        case capitalInfo
        case car
        case cioc
        case coatOfArms
        case continents
        case currencies
        case demonyms
        case independent
        case fifa
        case flag
        case flags
        case gini
        case landlocked
        case languages
        case latlng
        case maps
        case name
        case nativeName
        case population
        case postalCodes
        case region
        case startOfWeek
        case status
        case subregion
        case topLevelDomain
        case translations
        case unMember

    }

    
    case all([Field])
    case countryDetails(String, [Field])
    case countryAllDetails(String)
    
    public var urlScheme: String {
        "https"
    }
    
    public var host: String {
        "restcountries.com"
    }
    
    public var path: String {
        switch self {
        case .all:
            return "/v3.1/all"
        case .countryDetails(let country, _):
            return "/v3.1/name/\(country)"
        case .countryAllDetails(let country):
            return "/v3.1/name/\(country)"
        }
    }
    
    public var queryItems: [URLQueryItem] {
        switch self {
        case .all(let fields):
            return [.init(name: "fields", value: fields.reduce("", { $0.isEmpty ? $1.rawValue : "\($0),\($1.rawValue)" }))]
        case .countryDetails(_, let fields):
            return [.init(name: "fields", value: fields.reduce("", { $0.isEmpty ? $1.rawValue : "\($0),\($1.rawValue)" }))]
        case .countryAllDetails:
            return [.init(name: "fullText", value: "true")]
        }
    }
    
    public var urlCachePolicy: URLRequest.CachePolicy {
        .useProtocolCachePolicy
    }
}


