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
        case countryHighlights = 0
        case countryInfo = 1
        case flagAndCoatOfArms = 2
        case people = 3
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
        viewModel.fetchCountry()
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
        return [setupCountryHightlightSection(country: country), setupCountryInfoSection(country: country), setupCountryFlagAndCoatOfArms(country: country), setupPeopleSection(country: country)].compactMap { $0 }
    }
    
    
    // MARK: CountryHighlightSection
    
    private func setupCountryHightlightSection(country: Country) -> DiffableCollectionSection? {
        guard let name = country.name, let flags = country.flags else { return nil }
        let items:  [DiffableCollectionCellProvider] = [DiffableCollectionItem<CountryDetailFlagView>(.init(imagePath: flags.png, commonName: name.common, officialName: name.official))]
        
        let sectionLayout = NSCollectionLayoutSection.singleColumnLayout(width: .fractionalWidth(1.0), height: .estimated(54), insets: .section(.init(vertical: 16, horizontal: 20)))
        return .init(Section.countryHighlights.rawValue, cells: items, sectionLayout: sectionLayout)
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
    
    
    // MARK: Country Flag & CoatOfArms
    
    private func setupCountryFlagAndCoatOfArms(country: Country) -> DiffableCollectionSection? {
        guard let flags = country.flags, let coatOfArms = country.coatOfArms else { return nil }
        
        let imageModels: [ImageViewWithCaption.Model] = [.init(imagePath: flags.png, title: "Flag Description", caption: flags.description), .init(imagePath: coatOfArms.png, title: "Coat of Arms", caption: nil)]
        
        let items: [DiffableCollectionCellProvider] = imageModels.map { DiffableCollectionItem<ImageViewWithCaption>($0) }
        
        let layout = NSCollectionLayoutSection.gridLayout(itemSize: .init(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalWidth(0.7)), groupSpacing: .fixed(8), interGroupSpacing: 12)
        
        return .init(Section.flagAndCoatOfArms.rawValue, cells: items, sectionLayout: layout)
    }
    
    
    // MARK: Country People
    
    private func setupPeopleSection(country: Country) -> DiffableCollectionSection? {
        
        guard let population = country.population, let demonyms = country.demonyms?["eng"] else { return nil }
        
        let items: [DiffableCollectionCellProvider] = [DiffableCollectionItem<CountryInfoGridBox>(.init(title: "Population", info: "\(population)")), DiffableCollectionItem<CountryInfoGridBox>(.init(title: "Demonym (Female)", info: demonyms.female)), DiffableCollectionItem<CountryInfoGridBox>(.init(title: "Demonym (Male)", info: demonyms.male))]
        
        
        let layout = NSCollectionLayoutSection.threeItemGrid(insets: .init(vertical: 12, horizontal: 20)).addHeader()
        
        let header = CollectionSupplementaryView<SectionHeader>(.init(title: "Demographic", subtitle: "Information about the people in this country"))

        return .init(Section.people.rawValue, cells: items, header: header, sectionLayout: layout)
    }
    
}
