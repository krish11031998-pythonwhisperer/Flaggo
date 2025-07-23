//
//  CountryCapitalView.swift
//  Flaggo
//
//  Created by Krishna Venkatramani on 22/07/2025.
//

import Foundation
import SwiftUI
import KKit
import MapKit

public struct CountryCapitalView: ConfigurableView {
    
    public struct Model: Hashable {
        let captial: String
        let countryFlagEmoji: String
        let lat: Double
        let lon: Double
    }
    
    public let model: Model
    
    public init(model: Model) {
        self.model = model
    }
    
    public var body: some View {
        GroupBox("Captital") {
            VStack(alignment: .leading, spacing: 12) {
                Text(model.captial)
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(.primary)
//                Map {
//                    Annotation("", coordinate: .init(latitude: model.lat, longitude: model.lon)) {
//                        <#code#>
//                    }
//                }
            }
        }
    }
    
    public static var viewName: String { "CountryCapitalView" }
}
