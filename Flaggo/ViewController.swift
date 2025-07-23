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

class ViewController: UIViewController {

    private lazy var collectionView: DiffableCollectionView = .init()
    private let viewModel: CountryViewModel
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
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchCountries(refresh: false)
    }
    
    private func setupBindings() {
        viewModel.$countries
            .withUnretained(self)
            .sinkReceive { (vc, countries) in
                let cells: [DiffableCollectionCellProvider] = countries.compactMap{ country in
                    guard let cellModel = CountryCellView.Model(country: country) else { return nil }
                    return DiffableCollectionItem<CountryCellView>(cellModel)
                }
                
                let sectionLayout = NSCollectionLayoutSection.singleColumnLayout(width: .fractionalWidth(1.0), height: .estimated(54),
                                                                                 insets: .section(.init(vertical: 16, horizontal: 20)))
                #warning("Add section")
                let section = DiffableCollectionSection(0, cells: cells, sectionLayout: sectionLayout)
                
                vc.collectionView.reloadWithDynamicSection(sections: [section])
            }
            .store(in: &cancellables)
    }
    
    deinit {
        viewModel.cancelDanglingTasks()
    }
}
