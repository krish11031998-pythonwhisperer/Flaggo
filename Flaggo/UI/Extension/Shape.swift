//
//  Shape.swift
//  Flaggo
//
//  Created by Krishna Venkatramani on 22/07/2025.
//

import SwiftUI

 extension Shape where Self == RoundedRectangle {
    static func roundedRect(cornerRadius: CGFloat, style: RoundedCornerStyle = .continuous) -> RoundedRectangle {
        .init(cornerRadius: cornerRadius, style: style)
    }
}
