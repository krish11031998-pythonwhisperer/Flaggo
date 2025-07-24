//
//  RestCountryDetailService.swift
//  Flaggo
//
//  Created by Krishna Venkatramani on 24/07/2025.
//

import Foundation


public protocol CountryDetailService {
    func fetchDetailsOfCountry(for countryName: String, fields: [RestCountryEndpoint.Field]) async throws -> Country
    func fetchAllDetailsOfCountry(for countryName: String) async throws -> Country
}

class RestCountryDetailService: CountryDetailService {
    func fetchDetailsOfCountry(for countryName: String, fields: [RestCountryEndpoint.Field]) async throws -> Country {
        let countries: [Country] = try await RestCountryEndpoint.countryDetails(countryName, fields)
            .fetchRequest()
        
        guard let country = countries.first else {
            throw NSError(domain: "No Countries with the name: \(countryName) was found", code: -1100)
        }
        
        return country
    }
    
    func fetchAllDetailsOfCountry(for countryName: String) async throws -> Country {
        let countries: [Country] = try await RestCountryEndpoint.countryAllDetails(countryName)
            .fetchRequest()
        
        guard let country = countries.first else {
            throw NSError(domain: "No Countries with the name: \(countryName) was found", code: -1100)
        }
        
        return country
    }
}
