//
//  RestCountryDetailService.swift
//  Flaggo
//
//  Created by Krishna Venkatramani on 24/07/2025.
//

import Foundation

class RestCountryDetailService: CountryDetailService {
    func fetchDetailsOfCountry(for countryName: String, fields: [Field]) async throws -> Country {
        let countries: [Country] = try await RestCountryEndpoint.countryDetails(countryName, fields)
            .fetchRequest()
        
        guard let country = countries.first else {
            throw NetworkError.failedToFetch
        }
        
        return country
    }
    
    func fetchAllDetailsOfCountry(for countryName: String) async throws -> Country {
        let countries: [Country] = try await RestCountryEndpoint.countryAllDetails(countryName)
            .fetchRequest()
        
        guard let country = countries.first else {
            throw NetworkError.failedToFetch
        }
        
        return country
    }
}
