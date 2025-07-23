//
//  CountryViewModel.swift
//  Flaggo
//
//  Created by Krishna Venkatramani on 22/07/2025.
//

import Foundation

#warning("MAKE THIS A Protocol confirming Protocol")
class CountryViewModel {
    
    @Published private(set) var countries: [Country] = []
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
                self.countries = try await countryService.fetchAllConutries(fields: [.name, .flag, .flags])
                print("(DEBUG) countries: ", countries)
            } catch {
                print("(ERROR) error: ", error.localizedDescription)
            }
        }
    }
    
    func cancelDanglingTasks() {
        fetchCountryTask?.cancel()
    }
    
}
