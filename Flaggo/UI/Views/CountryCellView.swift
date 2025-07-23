//
//  CountryCellView.swift
//  Flaggo
//
//  Created by Krishna Venkatramani on 22/07/2025.
//

import KKit
import SwiftUI
import Kingfisher

public struct CountryCellView: ConfigurableView {
    
    public struct Config: Hashable {
        public let name: String
        public let officialName: String
        public let countryFlag: String
        public let imageURL: String
        
        public init(name: String, officialName: String, countryFlag: String, imageURL: String) {
            self.name = name
            self.officialName = officialName
            self.countryFlag = countryFlag
            self.imageURL = imageURL
        }
        
        public init?(country: Country) {
            guard let name = country.name,
                  let flag = country.flag,
                  let flags = country.flags else { return nil }
            self.name = name.common
            self.officialName = name.official
            self.countryFlag = flag
            self.imageURL = flags.png
        }
    }
    
    @State private var size: CGSize = .zero
    private let config: Config
    
    public init(model: Config) {
        self.config = model
    }
    
    public var body: some View {
        VStack(alignment: .center, spacing: 12) {
            KFImage(.init(string: config.imageURL))
                .resizable()
                .scaledToFill()
                .frame(width: size.width, height: size.height * 0.5)
                .clipped()
            
            VStack(alignment: .leading, spacing: 8) {
                Text("\(config.countryFlag) \(config.name)")
                    .font(.headline)
                
                Text(config.officialName)
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
            }
            .padding(.horizontal, 12)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .onGeometryChange(for: CGSize.self, of: { $0.size }) { newValue in
            self.size = newValue
        }
        .container(cornerRadius: 12)
    }
    
    
    // MARK: - Configurable
    
    public static var viewName: String { "CountryCellView" }
}
