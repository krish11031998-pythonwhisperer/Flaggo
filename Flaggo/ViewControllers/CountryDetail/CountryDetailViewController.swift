//
//  CountryDetailViewController.swift
//  Flaggo
//
//  Created by Krishna Venkatramani on 2025-07-23.
//

import Combine
import UIKit
import KKit

class CountryDetailViewController: BaseViewController {
    
    enum Section: Int {
        case countryHighlights = 0
        case languages = 1
        case nativeNames = 2
        case countryInfo = 3
        case people = 4
    }
    
    private lazy var animatableImageView: AnimatableImageView = .init()
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
        fetchCountryDetails()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.largeTitleDisplayMode = .never
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.contentInset.top = animatableImageView.frame.height + 20
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.largeTitleDisplayMode = .automatic
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(animatableImageView)
        animatableImageView
            .pinTopAnchorTo(anchor: \.safeAreaLayoutGuide.topAnchor, constant: 0)
            .pinHorizontalAnchorsTo(constant: 0)
        animatableImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25).isActive = true
        
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        collectionView.fillSuperview()
        collectionView.backgroundColor = .clear
    }
    
    private func setupBinding() {
        viewModel.$country
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.activityIndicator.stopAnimating()
            })
            .withUnretained(self)
            .sinkReceive { (vc, country) in
                let sections = vc.setupSections(country: country)
                vc.collectionView.reloadWithDynamicSection(sections: sections)
                
                if let countryFlag = country.coatOfArms {
                    vc.animatableImageView.setImage(imageURLPath: countryFlag.png)
                }
            }
            .store(in: &cancellables)
        
        viewModel.$error
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveOutput: { [weak self] _ in
                guard let self else { return }
                if self.activityIndicator.isAnimating {
                    self.activityIndicator.stopAnimating()
                }
            })
            .withUnretained(self)
            .sinkReceive { (vc, error) in
                vc.showErrorAlert(title: "Failed to fetch details of the country", message: error.localizedDescription)
            }
            .store(in: &cancellables)
        
        collectionView.publisher(for: \.contentOffset)
            .withUnretained(self)
            .sinkReceive { (vc, contentOff) in
                vc.animatableImageView.contentOffset = abs(min(0, contentOff.y)) - vc.collectionView.safeAreaInsets.top
            }
            .store(in: &cancellables)
    }
    
    
    // MARK: - Fetch Country Details
    
    private func fetchCountryDetails() {
        activityIndicator.startAnimating()
        viewModel.fetchCountry()
    }
    
    // MARK: - Section Setup
    
    private func setupSections(country: Country) -> [DiffableCollectionSection] {
        return [setupCountryHightlightSection(country: country),
                setupCountryLanguageSection(country: country),
                setupNativeNamesSection(country: country),
                setupCountryInfoSection(country: country),
                setupPeopleSection(country: country)].compactMap { $0 }
    }
    
    
    // MARK: CountryHighlightSection
    
    private func setupCountryHightlightSection(country: Country) -> DiffableCollectionSection? {
        guard let name = country.name, let flags = country.flags else { return nil }
        let items:  [DiffableCollectionCellProvider] = [DiffableCollectionItem<CountryDetailFlagView>(.init(imagePath: flags.png, commonName: name.common, officialName: name.official))]
        
        let sectionLayout = NSCollectionLayoutSection.singleColumnLayout(width: .fractionalWidth(1.0), height: .estimated(54), insets: .section(.init(vertical: 16, horizontal: 20)))
        return .init(Section.countryHighlights.rawValue, cells: items, sectionLayout: sectionLayout)
    }
    
    
    // MARK: CountryLanguageSection
    
    private func setupCountryLanguageSection(country: Country) -> DiffableCollectionSection? {
        guard let languages = country.languages, !languages.isEmpty else { return nil }
        
        let items = languages.map { (key: String, value: String) in
            DiffableCollectionItem<ChipView>(.init(title: value.capitalized))
        }
        
        let layout = NSCollectionLayoutSection.overflowLayout()
        layout.contentInsets = .init(vertical: 16, horizontal: 20)
        layout.addHeader()
        
        let header = CollectionSupplementaryView<SectionHeader>(.init(title: "Languages", subtitle: "Official languages spoken in the country"))
        
        return .init(Section.languages.rawValue, cells: items, header: header, sectionLayout: layout)
    }
    
    
    // MARK: Native Names
    
    private func setupNativeNamesSection(country: Country) -> DiffableCollectionSection? {
        guard let nativeNames = country.name?.nativeName, let languages = country.languages else { return nil }
        
        let items: [DiffableCollectionCellProvider] = nativeNames.compactMap { (key: String, value: Name) in
            guard let nameOfLanguage = languages[key] else { return nil }
            
            return DiffableCollectionItem<CountryInfoGridBox>(.init(title: nameOfLanguage, info: value.official, font: .headline))
        }
        
        let layout = NSCollectionLayoutSection.singleRowLayout(width: .estimated(54), height: .estimated(54), insets: .section(.init(vertical: 16, horizontal: 20)))
            .addHeader()
        
        let header = CollectionSupplementaryView<SectionHeader>(.init(title: "Native name", subtitle: "Native official names of the country"))
        
        return .init(Section.nativeNames.rawValue, cells: items, header: header, sectionLayout: layout)
    }
    
    
    // MARK: CountryInfoSection
    
    private func setupCountryInfoSection(country: Country) -> DiffableCollectionSection? {
        var items: [DiffableCollectionCellProvider] = []
        
        if let capital = country.capital?.first {
            items.append(DiffableCollectionItem<CountryInfoGridBox>(.init(title: "Capital", info: capital, font: .headline)))
        }
        
        if let region = country.region {
            items.append(DiffableCollectionItem<CountryInfoGridBox>(.init(title: "Region", info: region, font: .headline)))
        }
        
        if let subregion = country.subregion {
            items.append(DiffableCollectionItem<CountryInfoGridBox>(.init(title: "Sub-region", info: subregion, font: .headline)))
        }
        
        if let area = country.area {
            let measurementFormatter = MeasurementFormatter()
            let measurement = Measurement(value: .init(area), unit: UnitArea.squareKilometers)
            let areaString = measurementFormatter.string(from: measurement)
            items.append(DiffableCollectionItem<CountryInfoGridBox>(.init(title: "Area", info: areaString, font: .headline)))
        }
        
        let sectionLayout = NSCollectionLayoutSection.gridLayout(itemSize: .init(widthDimension: .fractionalWidth(0.5), heightDimension: .estimated(54)), groupSpacing: .fixed(8), interGroupSpacing: 8)
        sectionLayout.contentInsets = .init(vertical: 16, horizontal: 20)
        sectionLayout.addHeader()
        
        let header = CollectionSupplementaryView<SectionHeader>(.init(title: "Regional Information", subtitle: "Information about the country"))
        
        guard !items.isEmpty else { return nil }
        
        return .init(Section.countryInfo.rawValue, cells: items, header: header, sectionLayout: sectionLayout)
    }
    
    
    // MARK: Country People
    
    private func setupPeopleSection(country: Country) -> DiffableCollectionSection? {
        
        guard let population = country.population, let demonyms = country.demonyms?["eng"] else { return nil }
        
        var items: [DiffableCollectionCellProvider] = []
        
        // Population
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let populationString = numberFormatter.string(from: population as NSNumber) ?? "\(population)"
        items.append(DiffableCollectionItem<CountryInfoGridBox>(.init(title: "Population", info: populationString)))
        
        items.append(contentsOf: [DiffableCollectionItem<CountryInfoGridBox>(.init(title: "Demonym (Female)", info: demonyms.female)), DiffableCollectionItem<CountryInfoGridBox>(.init(title: "Demonym (Male)", info: demonyms.male))])
        
        
        let layout = NSCollectionLayoutSection.threeItemGrid(insets: .init(vertical: 16, horizontal: 20)).addHeader()
        
        let header = CollectionSupplementaryView<SectionHeader>(.init(title: "Demographic", subtitle: "Information about the people in this country"))

        return .init(Section.people.rawValue, cells: items, header: header, sectionLayout: layout)
    }
    
}
