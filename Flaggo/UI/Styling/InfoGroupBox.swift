//
//  InfoGroupBox.swift
//  Flaggo
//
//  Created by Krishna Venkatramani on 22/07/2025.
//

import Foundation
import SwiftUI

public struct InfoGroupBoxStyle: GroupBoxStyle {
    
    public func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            configuration.label
                .font(.body)
                .fontWeight(.medium)
                .foregroundStyle(.secondary)
            
            configuration.content
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .container(cornerRadius: 16)
    }
}


#Preview {
    GroupBox("Hello") {
        Text("Hello there!")
    }
    .groupBoxStyle(InfoGroupBoxStyle())
    .frame(width: 200, height: 350, alignment: .center)
}
