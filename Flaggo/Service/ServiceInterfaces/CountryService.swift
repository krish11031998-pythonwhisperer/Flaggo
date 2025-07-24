//
//  CountryService.swift
//  Flaggo
//
//  Created by Krishna Venkatramani on 2025-07-24.
//

import Foundation

protocol CountryService {
    func fetchAllConutries(fields: [Field]) async throws -> [Country]
}
