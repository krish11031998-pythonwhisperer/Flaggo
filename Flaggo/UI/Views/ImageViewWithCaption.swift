//
//  ImageViewWithCaption.swift
//  Flaggo
//
//  Created by Krishna Venkatramani on 24/07/2025.
//

import Kingfisher
import SwiftUI
import KKit

 struct ImageViewWithCaption: ConfigurableView {
    
    @State private var size: CGSize = .zero
    
     struct Model: Hashable {
        let imagePath: String
        let title: String
        let caption: String?
    
         init(imagePath: String, title: String, caption: String?) {
            self.imagePath = imagePath
            self.title = title
            self.caption = caption
        }
    }
    
    private let model: Model
    
     init(model: Model) {
        self.model = model
    }
    
     var body: some View {
        ZStack(alignment: .bottom) {
            KFImage(.init(string: model.imagePath))
                .resizable()
                .scaledToFill()
//                .frame(width: size.width, height: size.height, alignment: .center)
            
            Group {
                LinearGradient(stops: [.init(color: .black.opacity(0), location: 0), .init(color: .black.opacity(0.35), location: 0.5), .init(color: .black.opacity(0.5), location: 1)], startPoint: .top, endPoint: .bottom)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(model.title)
                        .font(.headline)
                        .foregroundStyle(.white)
                    
                    if let caption = model.caption {
                        Text(caption)
                            .font(.caption2)
                            .fontWeight(.medium)
                            .foregroundStyle(.white)
                    }
                }
                .padding(.all, 20)
            }
            .layoutPriority(2)
        }
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .onGeometryChange(for: CGSize.self, of: { $0.size }) { newValue in
            print("(DEBUG) size: ", newValue)
            self.size = newValue
        }
    }
    
     static var viewName: String { "ImageViewWithCaption" }
}

#Preview {
    ImageViewWithCaption(model: .init(imagePath: "https://flagcdn.com/md.svg", title: "Country Flag", caption: "The flag of Moldova is composed of three equal vertical bands of blue, yellow and red, with the national coat of arms centered in the yellow band."))
        .frame(width: 250, height: 250, alignment: .center)
}
