//
//  SectionHeader.swift
//  Flaggo
//
//  Created by Krishna Venkatramani on 2025-07-23.
//

import UIKit
import KKit

 class SectionHeader: UICollectionReusableView, ConfigurableCollectionSupplementaryView {
    
     struct Model: Hashable {
        let title: String
        let subtitle: String
        
         init(title: String, subtitle: String) {
            self.title = title
            self.subtitle = subtitle
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .label
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .secondaryLabel
        return label
    }()
    
     override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        let stackView = UIStackView.VStack(subViews: [titleLabel, subtitleLabel], spacing: 8, alignment: .leading)
        addSubview(stackView)
        stackView.fillSuperview()
    }

     func configure(with model: Model) {
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
    }
}

@available(iOS 17.0, *)
#Preview {
    let header = SectionHeader()
    header.configure(with: .init(title: "Hello", subtitle: "World"))
    return header
}
