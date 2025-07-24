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
    private var fetchCountryDetailTask: Task<Void, Never>?
    private let countryName: String
    private let countryDetailService: CountryDetailService
    
    init(name countryName: String, countryDetailService: CountryDetailService) {
        self.countryName = countryName
        self.countryDetailService = countryDetailService
    }
    
    func fetchCountry() {
        if fetchCountryDetailTask != nil {
            #warning("Handle accordingly")
            return
        }
        
        fetchCountryDetailTask = Task(priority: .userInitiated) {
            do {
                let country = try await countryDetailService.fetchAllDetailsOfCountry(for: countryName)
                await MainActor.run {
                    self.country = country
                }
            } catch let decodingError as DecodingError {
                switch decodingError {
                case .typeMismatch(let any, let context):
                    print("typeMismatch: \(any) - \(context)")
                case .valueNotFound(let any, let context):
                    print("valueNotFound: \(any) - \(context)")
                case .keyNotFound(let codingKey, let context):
                    print("keyNotFound: \(codingKey) - \(context)")
                case .dataCorrupted(let context):
                    print("dataCorrupted:\(context)")
                @unknown default:
                    fatalError()
                }
            } catch {
                print("(ERROR) error: ", error.localizedDescription)
            }
        }
    }
    
    func cancelDanglingTasks() {
        fetchCountryDetailTask?.cancel()
    }
}
