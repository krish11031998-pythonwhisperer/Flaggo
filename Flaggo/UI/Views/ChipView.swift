//
//  ChipView.swift
//  Flaggo
//
//  Created by Krishna Venkatramani on 24/07/2025.
//

import SwiftUI
import KKit

public struct ChipView: ConfigurableView {
    
    public struct Model: Hashable {
        let title: String
        let foregroundColor: Color
        let backgroundColor: Color
        
        public init(title: String, foregroundColor: Color = .primary, backgroundColor: Color = .init(uiColor: .secondarySystemFill)) {
            self.title = title
            self.foregroundColor = foregroundColor
            self.backgroundColor = backgroundColor
        }
    }
    
    private let model: Model
    
    public init(model: Model) {
        self.model = model
    }
    
    public var body: some View {
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
    
    public static var viewName: String { "ChipView" }
}
