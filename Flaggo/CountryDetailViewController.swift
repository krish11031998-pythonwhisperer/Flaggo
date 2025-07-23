//
//  CountryDetailViewController.swift
//  Flaggo
//
//  Created by Krishna Venkatramani on 2025-07-23.
//

import Combine
import UIKit
import KKit

class CountryDetailViewController: UIViewController {
    
    enum Section: Int {
        case countryInfo = 0
    }
    
    private lazy var collectionView: DiffableCollectionView = .init()
    private let viewModel: CountryDetailViewModel
    private var cancellables: Set<AnyCancellable> = .init()
    
    init(name: String, countryDetailService: CountryDetailService) {
        self.viewModel = .init(name: name, countryDetailService: countryDetailService)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBinding()
    }
    
    private func setupView() {
        view.addSubview(collectionView)
        collectionView.fillSuperview()
    }
    
    private func setupBinding() {
        viewModel.$country
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .withUnretained(self)
            .sinkReceive { (vc, country) in
                let sections = vc.setupSections(country: country)
                vc.collectionView.reloadWithDynamicSection(sections: sections)
            }
            .store(in: &cancellables)
    }
    
    
    // MARK: - Section Setup
    
    private func setupSections(country: Country) -> [DiffableCollectionSection] {
        return [setupCountryInfoSection(country: country)].compactMap { $0 }
    }
    
    
    // MARK: CountryInfoSection

    private func setupCountryInfoSection(country: Country) -> DiffableCollectionSection? {
        var items: [DiffableCollectionCellProvider] = []
        
        if let name = country.name {
            items.append(DiffableCollectionItem<CountryInfoGridBox>(.init(title: "Official Name", info: name.official)))
        }
        
        if let capital = country.capital?.first {
            items.append(DiffableCollectionItem<CountryInfoGridBox>(.init(title: "Capital", info: capital)))
        }
        
        if let region = country.region {
            items.append(DiffableCollectionItem<CountryInfoGridBox>(.init(title: "Region", info: region)))
        }
        
        let sectionLayout = NSCollectionLayoutSection.threeItemGrid(insets: .init(vertical: 12, horizontal: 20))
        sectionLayout.addHeader()
        
        let header = CollectionSupplementaryView<SectionHeader>(.init(title: "Regional Information", subtitle: "Information about the country"))
        
        guard !items.isEmpty else { return nil }
        
        return .init(Section.countryInfo.rawValue, cells: items, header: header, sectionLayout: sectionLayout)
    }
    
    
    // MARK: 
}
