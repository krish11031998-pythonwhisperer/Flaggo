//
//  Container.swift
//  Flaggo
//
//  Created by Krishna Venkatramani on 22/07/2025.
//

import SwiftUI

internal struct Container: ViewModifier {
    
    let cornerRadius: CGFloat
    
    init(cornerRadius: CGFloat) {
        self.cornerRadius = cornerRadius
    }
    
    func body(content: Content) -> some View {
        if #available(iOS 17.0, *) {
            content
                .background(.fill.secondary, in: .roundedRect(cornerRadius: cornerRadius))
        } else {
            content
                .background(alignment: .center) {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(.background)
                }
        }
    }
}

public extension View {
    func container(cornerRadius: CGFloat = 12) -> some View {
        self.modifier(Container(cornerRadius: cornerRadius))
    }
}
