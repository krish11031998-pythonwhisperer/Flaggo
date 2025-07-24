//
//  CountryDetailFlagView.swift
//  Flaggo
//
//  Created by Krishna Venkatramani on 24/07/2025.
//

import SwiftUI
import KKit
import Kingfisher

 struct CountryDetailFlagView: ConfigurableView {
    
     struct Model: Hashable {
        let imagePath: String
        let commonName: String
        let officialName: String
        
         init(imagePath: String, commonName: String, officialName: String) {
            self.imagePath = imagePath
            self.commonName = commonName
            self.officialName = officialName
        }
    }
    
    private let model: Model
    
     init(model: Model) {
        self.model = model
    }
    
     var body: some View {
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
    
     static var viewName: String { "CountryDetailFlagView" }
}

#Preview{
    CountryDetailFlagView(model: .init(imagePath: "https://flagcdn.com/w320/md.png", commonName: "Moldova", officialName: "Re of Moldova"))
        .padding(.horizontal, 20)
}
