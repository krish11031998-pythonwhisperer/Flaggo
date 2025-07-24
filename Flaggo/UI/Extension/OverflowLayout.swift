//
//  OverflowLayout.swift
//  Flaggo
//
//  Created by Krishna Venkatramani on 24/07/2025.
//

import UIKit

public extension NSCollectionLayoutSection {
    
    static func overflowLayout(interItemSpacing: CGFloat = 8, interGroupSpacing: CGFloat = 12) -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .estimated(54), heightDimension: .estimated(54)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(54)), subitems: [item])
        group.interItemSpacing = .fixed(interItemSpacing)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = interGroupSpacing
        
        return section
    }
    
}
