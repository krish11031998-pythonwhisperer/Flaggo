//
//  CountryDetailFlagView.swift
//  Flaggo
//
//  Created by Krishna Venkatramani on 24/07/2025.
//

import SwiftUI
import KKit
import Kingfisher

public struct CountryDetailFlagView: ConfigurableView {
    
    public struct Model: Hashable {
        let imagePath: String
        let commonName: String
        let officialName: String
        
        public init(imagePath: String, commonName: String, officialName: String) {
            self.imagePath = imagePath
            self.commonName = commonName
            self.officialName = officialName
        }
    }
    
    private let model: Model
    
    public init(model: Model) {
        self.model = model
    }
    
    public var body: some View {
        HStack(alignment: .center, spacing: 16) {
            KFImage(.init(string: model.imagePath))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 72, height: 72, alignment: .center)
                .clipped()
            
            VStack(alignment: .leading, spacing: 4) {
                Text(model.commonName)
                    .font(.title)
                    .fontWeight(.semibold)
                    
                Text(model.officialName)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    public static var viewName: String { "CountryDetailFlagView" }
}

#Preview{
    CountryDetailFlagView(model: .init(imagePath: "https://flagcdn.com/w320/md.png", commonName: "Moldova", officialName: "Republic of Moldova"))
        .padding(.horizontal, 20)
}
