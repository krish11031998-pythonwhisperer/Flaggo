//
//  CountryDetailService.swift
//  Flaggo
//
//  Created by Krishna Venkatramani on 2025-07-24.
//

import Foundation

protocol CountryDetailService {
    func fetchDetailsOfCountry(for countryName: String, fields: [Field]) async throws -> Country
    func fetchAllDetailsOfCountry(for countryName: String) async throws -> Country
}
