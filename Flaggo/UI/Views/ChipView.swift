//
//  ChipView.swift
//  Flaggo
//
//  Created by Krishna Venkatramani on 24/07/2025.
//

import SwiftUI
import KKit

 struct ChipView: ConfigurableView {
    
     struct Model: Hashable {
        let title: String
        let foregroundColor: Color
        let backgroundColor: Color
        
         init(title: String, foregroundColor: Color = .primary, backgroundColor: Color = .init(uiColor: .secondarySystemFill)) {
            self.title = title
            self.foregroundColor = foregroundColor
            self.backgroundColor = backgroundColor
        }
    }
    
    private let model: Model
    
     init(model: Model) {
        self.model = model
    }
    
     var body: some View {
        Text(model.title)
            .font(.headline)
            .foregroundStyle(model.foregroundColor)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(alignment: .center) {
                model.backgroundColor
            }
            .clipShape(Capsule())
    }
    
     static var viewName: String { "ChipView" }
}
