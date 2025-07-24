//
//  CountryListViewModel.swift
//  Flaggo
//
//  Created by Krishna Venkatramani on 22/07/2025.
//

import Foundation

class CountryListViewModel {
    
    @Published private(set) var countries: [Country]? = nil
    @Published private(set) var error: Error? = nil
    private var fetchCountryTask: Task<Void, Never>?
    
    private let countryService: CountryService
    
    init(countryService: CountryService) {
        self.countryService = countryService
    }
    
    func fetchCountries(refresh: Bool) {
        if fetchCountryTask != nil {
            if refresh {
                fetchCountryTask?.cancel()
            } else {
                return
            }
        }
        
        fetchCountryTask = Task(priority: .userInitiated) {
            do {
                let countries = try await countryService.fetchAllConutries(fields: [.name, .flag, .flags])
                try Task.checkCancellation()
                await MainActor.run {
                    self.countries = countries
                }
                
            } catch {
                await MainActor.run {
                    self.error = error
                }
            }
        }
    }
    
    func cancelDanglingTasks() {
        fetchCountryTask?.cancel()
    }
    
}
