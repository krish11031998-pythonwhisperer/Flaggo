//
//  ViewController.swift
//  Flaggo
//
//  Created by Krishna Venkatramani on 22/07/2025.
//

import UIKit
import KKit
import SwiftUI
import Combine

class CountryListViewController: RootViewController {

    private lazy var collectionView: DiffableCollectionView = .init()
    private let viewModel: CountryListViewModel
    private var cancellables: Set<AnyCancellable> = .init()
    
    init(countryService: CountryService) {
        self.viewModel = .init(countryService: countryService)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        collectionView.fillSuperview()
        view.backgroundColor = .systemBackground
        collectionView.backgroundColor = .clear
        setupBindings()
        fetchCountries()
    }
    
    private func setupBindings() {
        viewModel.$countries
            .dropFirst(1)
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.activityIndicator.stopAnimating()
            })
            .withUnretained(self)
            .sinkReceive { (vc, countries) in
                vc.collectionView.reloadWithDynamicSection(sections: vc.setupCountriesSection(countries: countries))
            }
            .store(in: &cancellables)
    }
    
    
    // MARK: - Fetch
    
    private func fetchCountries() {
        activityIndicator.startAnimating()
        viewModel.fetchCountries(refresh: false)
    }
    
    
    // MARK: - Collection Setup
    
    private func setupCountriesSection(countries: [Country]) -> [DiffableCollectionSection] {
        let cells: [DiffableCollectionCellProvider] = countries.compactMap{ country in
            let cellModel = CountryCellView.Model(country: country) { [weak self] in
                self?.pushDetailsScreen(country: country)
            }
            guard let cellModel else { return nil }
            return DiffableCollectionItem<CountryCellView>(cellModel)
        }
        
        let header = CollectionSupplementaryView<SectionHeader>(.init(title: "Countries", subtitle: "Explore the world"))
        let sectionLayout = NSCollectionLayoutSection.gridLayout(itemSize: .init(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalWidth(0.67)), groupSpacing: .fixed(8), interGroupSpacing: 12)
        sectionLayout.addHeader()
        
        let section = DiffableCollectionSection(0, cells: cells, header: header, sectionLayout: sectionLayout)
        
        return [section]
    }
    
    
    // MARK: - Navigation
    
    private func pushDetailsScreen(country: Country) {
        guard let name = country.name else { return }
        let viewController = CountryDetailViewController(name: name.common, countryDetailService: RestCountryDetailService())
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    deinit {
        viewModel.cancelDanglingTasks()
    }
}
