//
//  CountryInfoGridBox.swift
//  Flaggo
//
//  Created by Krishna Venkatramani on 22/07/2025.
//

import KKit
import SwiftUI

 struct CountryInfoGridBox: ConfigurableView {
    
     struct Model: Hashable {
        let title: String
        let info: String
        let font: Font
        
         init(title: String, info: String, font: Font = .title) {
            self.title = title
            self.info = info
            self.font = font
        }
    }
    
    private let model: Model
    
     init(model: Model) {
        self.model = model
    }
    
     var body: some View {
        GroupBox(model.title) {
            Text(model.info)
                .font(model.font)
                .fontWeight(.semibold)
                .foregroundStyle(.primary)
        }
        .groupBoxStyle(InfoGroupBoxStyle())
        .dynamicTypeSize(..<DynamicTypeSize.large)
    }
    
     static var viewName: String { "CountryInfoView" }
}


#Preview {
    HStack(alignment: .center, spacing: 0) {
        CountryInfoGridBox(model: .init(title: "Native Name", info: "Iceland"))
            .padding(.leading, 20)
            .padding(.trailing, 10)
            .aspectRatio(1.25, contentMode: .fit)
            .frame(maxWidth: .infinity, alignment: .leading)
        CountryInfoGridBox(model: .init(title: "Native Name", info: "Icelandeds Icelandeds"))
            .padding(.leading, 10)
            .padding(.trailing, 20)
            .aspectRatio(1.25, contentMode: .fit)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    .frame(maxWidth: .infinity, alignment: .leading)
}
