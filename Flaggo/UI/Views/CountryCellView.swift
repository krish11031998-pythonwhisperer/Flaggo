//
//  CountryCellView.swift
//  Flaggo
//
//  Created by Krishna Venkatramani on 22/07/2025.
//

import KKit
import SwiftUI
import Kingfisher

 struct CountryCellView: ConfigurableView {
    
     struct Config: ActionProvider, Hashable {
         let name: String
         let officialName: String
         let countryFlag: String
         let imageURL: String
         var action: Callback?
        
         init(name: String, officialName: String, countryFlag: String, imageURL: String, action: Callback?) {
            self.name = name
            self.officialName = officialName
            self.countryFlag = countryFlag
            self.imageURL = imageURL
            self.action = action
        }
        
         init?(country: Country, action: Callback?) {
            guard let name = country.name,
                  let flag = country.flag,
                  let flags = country.flags else { return nil }
            self.name = name.common
            self.officialName = name.official
            self.countryFlag = flag
            self.imageURL = flags.png
            self.action = action
        }
        
         func hash(into hasher: inout Hasher) {
            hasher.combine(name)
            hasher.combine(officialName)
            hasher.combine(countryFlag)
            hasher.combine(imageURL)
        }
        
         static func == (lhs: Config, rhs: Config) -> Bool {
            return lhs.name == rhs.name && lhs.officialName == rhs.officialName && lhs.countryFlag == rhs.countryFlag && lhs.imageURL == rhs.imageURL
        }
    }
    
    @State private var size: CGSize = .zero
    private let config: Config
    
     init(model: Config) {
        self.config = model
    }
    
     var body: some View {
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
    
     static var viewName: String { "CountryCellView" }
}
