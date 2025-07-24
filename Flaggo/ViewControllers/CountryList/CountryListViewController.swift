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

class CountryListViewController: UIViewController {

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
        // Do any additional setup after loading the view.
        view.addSubview(collectionView)
        collectionView.fillSuperview()
        viewModel.fetchCountries(refresh: false)
        setupBindings()
    }
    
    private func setupBindings() {
        viewModel.$countries
            .dropFirst(1)
            .withUnretained(self)
            .sinkReceive { (vc, countries) in
                let cells: [DiffableCollectionCellProvider] = countries.compactMap{ country in
                    let cellModel = CountryCellView.Model(country: country) { [weak vc] in
                        vc?.presentDetailsScreen(country: country)
                    }
                    guard let cellModel else { return nil }
                    return DiffableCollectionItem<CountryCellView>(cellModel)
                }
                
                let header = CollectionSupplementaryView<SectionHeader>(.init(title: "Countries", subtitle: "Explore the world"))
                let sectionLayout = NSCollectionLayoutSection.gridLayout(itemSize: .init(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalWidth(0.67)), groupSpacing: .fixed(8), interGroupSpacing: 12)
                sectionLayout.addHeader()
                #warning("Add section")
                let section = DiffableCollectionSection(0, cells: cells, header: header, sectionLayout: sectionLayout)
                
                vc.collectionView.reloadWithDynamicSection(sections: [section])
            }
            .store(in: &cancellables)
    }
    
    private func presentDetailsScreen(country: Country) {
        guard let name = country.name else { return }
        let viewController = CountryDetailViewController(name: name.common, countryDetailService: RestCountryDetailService())
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    deinit {
        viewModel.cancelDanglingTasks()
    }
}
