//
//  CountryCellView.swift
//  Flaggo
//
//  Created by Krishna Venkatramani on 22/07/2025.
//

import KKit
import SwiftUI

public struct CountryCellView: ConfigurableView {
    
    public struct Config: Hashable {
        public let name: String
        public let officialName: String
        public let countryFlag: String
        
        public init(name: String, officialName: String, countryFlag: String) {
            self.name = name
            self.officialName = officialName
            self.countryFlag = countryFlag
        }
        
        public init?(country: Country) {
            guard let name = country.name, let flag = country.flag else { return nil }
            self.name = name.common
            self.officialName = name.official
            self.countryFlag = flag
        }
    }
    
    private let config: Config
    
    public init(model: Config) {
        self.config = model
    }
    
    public var body: some View {
        HStack(alignment: .center, spacing: 12) {
            #warning("Add Image here")
            Text(config.countryFlag)
                .font(.title)
                
            VStack(alignment: .leading, spacing: 8) {
                Text(config.name)
                    .font(.headline)
                
                Text(config.officialName)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .container(cornerRadius: 12)
    }
    
    
    // MARK: - Configurable
    
    public static var viewName: String { "CountryCellView" }
}

