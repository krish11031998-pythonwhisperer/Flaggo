//
//  RestCountriesService.swift
//  Flaggo
//
//  Created by Krishna Venkatramani on 22/07/2025.
//

import Foundation

class RestCountriesService: CountryService {
    
    func fetchAllConutries(fields: [Field]) async throws -> [Country] {
        try await RestCountryEndpoint.all(fields)
            .fetchRequest()
    }
}
