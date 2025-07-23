//
//  RestCountriesService.swift
//  Flaggo
//
//  Created by Krishna Venkatramani on 22/07/2025.
//

import Foundation

protocol CountryService {
    func fetchAllConutries(fields: [RestCountryEndpoint.Field]) async throws -> [Country]
}


class RestCountriesService: CountryService {
    
    func fetchAllConutries(fields: [RestCountryEndpoint.Field]) async throws -> [Country] {
        try await RestCountryEndpoint.all(fields)
            .fetchRequest()
    }
    
}
