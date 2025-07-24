//
//  ThreeItemGrid.swift
//  Flaggo
//
//  Created by Krishna Venkatramani on 2025-07-23.
//

import UIKit
import KKit

 extension NSCollectionLayoutSection {
    
    static func threeItemGrid(insets: NSDirectionalEdgeInsets = .init(by: 8)) -> NSCollectionLayoutSection {
        let largeItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
        let smallItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5))
        
        // Items
        let largeItem: NSCollectionLayoutItem = .init(layoutSize: largeItemSize)
        let smallItem: NSCollectionLayoutItem = .init(layoutSize: smallItemSize)
        
        // Small Group
        let smallGroup = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0)), repeatingSubitem: smallItem, count: 2)
        smallGroup.interItemSpacing = .fixed(8)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.6)), subitems: [largeItem, smallGroup])
        group.interItemSpacing = .fixed(8)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = insets
        
        return section
    }
}

fileprivate class TestView: UIView {
    
    private lazy var collectionView: DiffableCollectionView = .init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView() {
        addSubview(collectionView)
        collectionView.fillSuperview()
        
        let items: [CountryInfoGridBox.Model] = [.init(title: "Capital", info: "Stockholm"), .init(title: "Country", info: "Sweden"), .init(title: "Continent", info: "Europe")]
        let cells = items.map { DiffableCollectionItem<CountryInfoGridBox>($0) }
        let sectionLayout = NSCollectionLayoutSection.threeItemGrid(insets: .init(by: 20))
        
        let section = DiffableCollectionSection(0, cells: cells, sectionLayout: sectionLayout)
        
        collectionView.reloadWithDynamicSection(sections: [section])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

@available(iOS 17.0, *)
#Preview {
    TestView()
}
