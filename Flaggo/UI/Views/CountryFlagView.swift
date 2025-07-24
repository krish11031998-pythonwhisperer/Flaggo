//
//  CountryFlagView.swift
//  Flaggo
//
//  Created by Krishna Venkatramani on 2025-07-23.
//

import SwiftUI
import KKit
import Kingfisher

 struct CountryFlagView: ConfigurableView {
    
     struct Model: Hashable {
        let imagePath: String
        let name: String
        
         init(imagePath: String, name: String) {
            self.imagePath = imagePath
            self.name = name
        }
    }
    
    @Environment(\.colorScheme) var colorScheme
    private let model: Model
    
     init(model: Model) {
        self.model = model
    }
    
     var body: some View {
        ZStack(alignment: .center) {
            KFImage(.init(string: model.imagePath))
                .resizable()
                .clipped()
            Text(model.name)
                .font(.headline)
                .foregroundStyle(.white)
                .padding(.vertical, 20)
                .padding(.horizontal, 16)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .background {
                    LinearGradient(stops: [.init(color: Color.black.opacity(0.3), location: 0), .init(color: Color.black.opacity(0.1), location: 0.2), .init(color: Color.clear, location: 1)], startPoint: .top, endPoint: .bottom)
                }
        }
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
    
    
    // MARK: - Helpers
    
    private var color: Color {
        switch colorScheme {
        case .dark:
            Color.black
        case .light:
            Color.white
        @unknown default:
            fatalError()
        }
    }
    
    // MARK: - Configurable
     static var viewName: String { "CountryFlagView" }
}

@available(iOS 17.0, *)
#Preview {
    CountryFlagView(model: .init(imagePath: "https://flagcdn.com/w320/se.png", name: "Sweden"))
        .frame(width: 320, height: 320)
}
