//
//  CountryDetailViewModel.swift
//  Flaggo
//
//  Created by Krishna Venkatramani on 24/07/2025.
//

import Foundation
import Combine

class CountryDetailViewModel {
    
    @Published private(set) var country: Country? = nil
    @Published private(set) var error: Error? = nil
    private var fetchCountryDetailTask: Task<Void, Never>?
    private let countryName: String
    private let countryDetailService: CountryDetailService
    
    init(name countryName: String, countryDetailService: CountryDetailService) {
        self.countryName = countryName
        self.countryDetailService = countryDetailService
    }
    
    func fetchCountry() {
        if fetchCountryDetailTask != nil {
            return
        }
        
        fetchCountryDetailTask = Task(priority: .userInitiated) {
            do {
                let country = try await countryDetailService.fetchAllDetailsOfCountry(for: countryName)
                try Task.checkCancellation()
                await MainActor.run {
                    self.country = country
                }
            } catch {
                await MainActor.run {
                    self.error = error
                }
            }
        }
    }
    
    func cancelDanglingTasks() {
        fetchCountryDetailTask?.cancel()
    }
}
