//
//  MainTabViewController.swift
//  Flaggo
//
//  Created by Krishna Venkatramani on 2025-07-23.
//

import UIKit


class MainTabViewController: UITabBarController {
    
    enum Tabs: Int, CaseIterable {
        case countries = 0
        
        var tabName: String {
            switch self {
            case .countries:
                return "Countries"
            }
        }
        
        var tabIcon: UIImage? {
            switch self {
            case .countries:
                return .init(systemName: "flag")
            }
        }
        
        var tabItem: UITabBarItem {
            switch self {
            case .countries:
                    .init(title: tabName, image: tabIcon, tag: rawValue)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabViewControllers = Tabs.allCases.map(setupTab(tab:))
        self.setViewControllers(tabViewControllers, animated: false)
        
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithDefaultBackground()
        tabBar.standardAppearance = tabBarAppearance
        tabBar.scrollEdgeAppearance = tabBarAppearance
    }
    
    private func setupTab(tab: Tabs) -> UIViewController {
        let viewController: RootViewController
        
        switch tab {
        case .countries:
            viewController = CountryListViewController(countryService: RestCountriesService())
        }
        
        return RootTabViewController(tab: tab, rootViewController: viewController)
    }
}
